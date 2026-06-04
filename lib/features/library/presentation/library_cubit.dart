import 'package:bloc/bloc.dart';

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../editor/domain/process_models.dart';
import '../../whatsapp/domain/models/whatsapp_add_result/whatsapp_add_result.dart';
import '../../whatsapp/domain/whatsapp_sticker_exception.dart';
import '../../whatsapp/domain/whatsapp_target.dart';
import '../../whatsapp/whatsapp_stickers.dart';
import '../data/pack_exporter.dart';
import '../data/pack_importer.dart';
import '../data/pack_share_service.dart';
import '../data/pack_store.dart';
import '../domain/pack_models.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(
    this._packStore,
    this._whatsAppStickers,
    this._packExporter,
    this._packImporter,
    this._packShareService,
  ) : super(const LibraryState());

  final PackStore _packStore;
  final WhatsAppStickers _whatsAppStickers;
  final PackExporter _packExporter;
  final PackImporter _packImporter;
  final PackShareService _packShareService;

  Future<void> loadLocalPacks() async {
    emit(state.copyWith(loading: true, error: null));
    final result = await _packStore.loadPacks();
    final packs = result.valueOrNull ?? state.packs;
    final invalidPacks = result.isSuccess
        ? await _buildInvalidPackMap(packs)
        : state.invalidPacks;
    emit(
      state.copyWith(
        loading: false,
        packs: packs,
        invalidPacks: invalidPacks,
        error: result.errorOrNull,
      ),
    );
  }

  Future<void> createPack({
    required String name,
    required String publisher,
    String? packId,
  }) async {
    final result = await _packStore.createPack(
      name: name,
      publisher: publisher,
      packId: packId,
    );
    await _applyPackResult(result);
  }

  Future<void> updatePackMetadata({
    required String packId,
    required String name,
    required String publisher,
  }) async {
    final result = await _packStore.updatePackMetadata(
      packId: packId,
      name: name,
      publisher: publisher,
    );
    await _applyPackResult(result);
  }

  Future<void> addProcessedSticker({
    required String packId,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
    List<String> emojis = const <String>[],
    String accessibilityText = '',
  }) async {
    final saveResult = await _packStore.addSticker(
      packId: packId,
      result: result,
      editableSourcePath: editableSourcePath,
      editStateJson: editStateJson,
      emojis: emojis,
      accessibilityText: accessibilityText,
    );
    if (saveResult.isSuccess) {
      emit(state.copyWith(lastSavedSticker: result));
    }
    await _applyPackResult(saveResult);
  }

  Future<void> setProcessedTray({
    required String packId,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
  }) async {
    final saveResult = await _packStore.setTray(
      packId: packId,
      result: result,
      editableSourcePath: editableSourcePath,
      editStateJson: editStateJson,
    );
    if (saveResult.isSuccess) {
      emit(state.copyWith(lastSavedTray: result));
    }
    await _applyPackResult(saveResult);
  }

  Future<void> replaceProcessedSticker({
    required String packId,
    required String fileName,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
    List<String>? emojis,
    String? accessibilityText,
  }) async {
    final saveResult = await _packStore.replaceSticker(
      packId: packId,
      fileName: fileName,
      result: result,
      editableSourcePath: editableSourcePath,
      editStateJson: editStateJson,
      emojis: emojis,
      accessibilityText: accessibilityText,
    );
    if (saveResult.isSuccess) {
      emit(state.copyWith(lastSavedSticker: result));
    }
    await _applyPackResult(saveResult);
  }

  Future<void> removeSticker({
    required String packId,
    required String fileName,
  }) async {
    final result = await _packStore.removeSticker(
      packId: packId,
      fileName: fileName,
    );
    await _applyPackResult(result);
  }

  Future<void> validatePack(String packId) async {
    final result = await _packStore.validatePack(packId);
    final invalidPacks = Map<String, AppError>.from(state.invalidPacks);
    if (result.isSuccess) {
      invalidPacks.remove(packId);
    } else if (result.errorOrNull != null) {
      invalidPacks[packId] = result.errorOrNull!;
    }
    emit(state.copyWith(invalidPacks: invalidPacks, error: result.errorOrNull));
  }

  Future<void> deletePack(String packId) async {
    final result = await _packStore.deletePack(packId);
    if (result.isSuccess) {
      final remaining = state.packs
          .where((pack) => pack.id != packId)
          .toList(growable: false);
      final invalidPacks = Map<String, AppError>.from(state.invalidPacks)
        ..remove(packId);
      emit(
        state.copyWith(
          packs: remaining,
          invalidPacks: invalidPacks,
          error: null,
        ),
      );
      return;
    }
    emit(state.copyWith(error: result.errorOrNull));
  }

  Future<List<WhatsAppTarget>> getExportTargets(String packId) async {
    try {
      final status = await _whatsAppStickers.packStatus(packId);
      return status.installed;
    } on WhatsAppStickerException catch (error) {
      emit(state.copyWith(error: error.toAppError()));
      return const <WhatsAppTarget>[];
    } on Object catch (error) {
      emit(
        state.copyWith(
          error: AppError.platform(
            message: PackMessages.queryTargetsFailed,
            debugDetails: error.toString(),
          ),
        ),
      );
      return const <WhatsAppTarget>[];
    }
  }

  Future<void> exportPack(
    String packId, {
    WhatsAppTarget? preferredTarget,
  }) async {
    if (state.exportingPackId == packId) {
      return;
    }
    emit(state.copyWith(exportingPackId: packId, error: null, waStatus: null));
    try {
      final packValidation = await _packStore.validatePack(packId);
      if (packValidation.isFailure) {
        emit(
          state.copyWith(
            exportingPackId: null,
            error: packValidation.errorOrNull,
          ),
        );
        return;
      }
      final status = await _whatsAppStickers.packStatus(packId);
      if (status.installed.isEmpty) {
        emit(
          state.copyWith(
            exportingPackId: null,
            error: const AppError.noCompatibleTarget(),
          ),
        );
        return;
      }
      if (preferredTarget == WhatsAppTarget.consumer &&
          !status.installed.contains(WhatsAppTarget.consumer)) {
        emit(
          state.copyWith(
            exportingPackId: null,
            error: const AppError.whatsappMissing(),
          ),
        );
        return;
      }
      if (preferredTarget == WhatsAppTarget.business &&
          !status.installed.contains(WhatsAppTarget.business)) {
        emit(
          state.copyWith(
            exportingPackId: null,
            error: const AppError.businessMissing(),
          ),
        );
        return;
      }
      final pack = packValidation.valueOrNull!;
      final result = await _whatsAppStickers.addPack(
        packId: pack.id,
        packName: pack.name,
      );
      emit(
        state.copyWith(
          exportingPackId: null,
          waStatus: result,
          error: _errorFromWhatsAppResult(result),
        ),
      );
    } on WhatsAppStickerException catch (error) {
      emit(state.copyWith(exportingPackId: null, error: error.toAppError()));
    } on Object catch (error) {
      emit(
        state.copyWith(
          exportingPackId: null,
          error: AppError.platform(
            message: PackMessages.launchExportFailed,
            debugDetails: error.toString(),
          ),
        ),
      );
    }
  }

  Future<void> sharePack(String packId) async {
    if (state.sharingPackId == packId) {
      return;
    }
    final pack = _packStore.getById(packId);
    if (pack == null) {
      emit(
        state.copyWith(
          error: const AppError.validation(message: PackMessages.packNotFound),
        ),
      );
      return;
    }

    emit(state.copyWith(sharingPackId: packId, error: null));
    final exportResult = await _packExporter.export(pack);
    if (exportResult.isFailure) {
      emit(
        state.copyWith(sharingPackId: null, error: exportResult.errorOrNull),
      );
      return;
    }
    final shareResult = await _packShareService.share(
      exportResult.valueOrNull!,
    );
    emit(state.copyWith(sharingPackId: null, error: shareResult.errorOrNull));
  }

  Future<void> importPack(String source) async {
    emit(state.copyWith(importing: true, error: null, importedPackId: null));
    final result = await _packImporter.importFromUri(source);
    await _applyImportResult(result);
  }

  Future<void> importPendingPack() async {
    final source = await _packImporter.takePendingSource();
    if (source == null || source.isEmpty) {
      return;
    }
    await importPack(source);
  }

  void clearError() {
    if (state.error == null) {
      return;
    }
    emit(state.copyWith(error: null));
  }

  void clearWaStatus() {
    if (state.waStatus == null) {
      return;
    }
    emit(state.copyWith(waStatus: null));
  }

  void clearImportedPack() {
    if (state.importedPackId == null) {
      return;
    }
    emit(state.copyWith(importedPackId: null));
  }

  Future<void> _applyPackResult(AppResult<StickerPack> result) async {
    if (result.isFailure) {
      emit(state.copyWith(error: result.errorOrNull));
      return;
    }
    final pack = result.valueOrNull!;
    final packs =
        <StickerPack>[...state.packs.where((item) => item.id != pack.id), pack]
          ..sort((left, right) {
            final byName = left.name.toLowerCase().compareTo(
              right.name.toLowerCase(),
            );
            if (byName != 0) {
              return byName;
            }
            return left.id.compareTo(right.id);
          });
    final invalidPacks = Map<String, AppError>.from(state.invalidPacks);
    final validation = await _packStore.validatePack(pack.id);
    if (validation.isSuccess) {
      invalidPacks.remove(pack.id);
    } else if (validation.errorOrNull != null) {
      invalidPacks[pack.id] = validation.errorOrNull!;
    }
    emit(state.copyWith(packs: packs, invalidPacks: invalidPacks, error: null));
  }

  Future<void> _applyImportResult(AppResult<StickerPack> result) async {
    if (result.isFailure) {
      emit(
        state.copyWith(
          importing: false,
          importedPackId: null,
          error: result.errorOrNull,
        ),
      );
      return;
    }
    final pack = result.valueOrNull!;
    await _applyPackResult(result);
    emit(
      state.copyWith(importing: false, importedPackId: pack.id, error: null),
    );
  }

  Future<Map<String, AppError>> _buildInvalidPackMap(
    List<StickerPack> packs,
  ) async {
    final invalidPacks = <String, AppError>{};
    for (final pack in packs) {
      final validation = await _packStore.validatePack(pack.id);
      if (validation.isFailure && validation.errorOrNull != null) {
        invalidPacks[pack.id] = validation.errorOrNull!;
      }
    }
    return invalidPacks;
  }

  AppError? _errorFromWhatsAppResult(WhatsAppAddResult result) {
    return switch (result.status) {
      WhatsAppAddStatus.completed || WhatsAppAddStatus.alreadyAdded => null,
      WhatsAppAddStatus.cancelled => const AppError.exportCancelled(),
      WhatsAppAddStatus.rejected => AppError.exportRejected(
        reason: result.validationError,
        debugDetails: result.validationError,
      ),
      WhatsAppAddStatus.missing => const AppError.noCompatibleTarget(),
      WhatsAppAddStatus.providerUnavailable =>
        const AppError.providerUnavailable(),
    };
  }
}
