import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/app_error.dart';
import '../../editor/domain/process_models.dart';
import '../../whatsapp/domain/models/whatsapp_add_result/whatsapp_add_result.dart';
import '../domain/pack_models.dart';

part 'library_state.freezed.dart';

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(<StickerPack>[]) List<StickerPack> packs,
    @Default(<String, AppError>{}) Map<String, AppError> invalidPacks,
    @Default(false) bool loading,
    @Default(false) bool importing,
    String? exportingPackId,
    String? sharingPackId,
    String? importedPackId,
    WhatsAppAddResult? waStatus,
    AppError? error,
    ProcessResult? lastSavedSticker,
    ProcessResult? lastSavedTray,
  }) = _LibraryState;
}
