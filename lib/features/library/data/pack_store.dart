import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../editor/domain/process_models.dart';
import '../data/io/library_dirs.dart';
import '../data/io/file_ops.dart';
import '../data/io/json_store.dart';
import '../domain/pack_models.dart';
import '../domain/pack_validator.dart';
import '../util/library_ids.dart';

class PackStore {
  PackStore(this._appDirs, this._fileOps, this._jsonStore, this._validator);

  final LibraryDirs _appDirs;
  final FileOps _fileOps;
  final JsonStore _jsonStore;
  final PackValidator _validator;

  final Map<String, StickerPack> _packs = <String, StickerPack>{};
  var _loaded = false;

  UnmodifiableMapView<String, StickerPack> get cache =>
      UnmodifiableMapView<String, StickerPack>(_packs);

  StickerPack? getById(String packId) => _packs[packId];

  Future<AppResult<List<StickerPack>>> loadPacks() async {
    try {
      final packsDir = await _appDirs.packs();
      final directories = await _fileOps.listDirectories(packsDir.path);
      final loaded = <String, StickerPack>{};

      for (final directory in directories) {
        final manifestPath = p.join(directory.path, PackFiles.manifestFileName);
        if (!await _fileOps.fileExists(manifestPath)) {
          continue;
        }
        try {
          final json = await _jsonStore.readMap(manifestPath);
          final manifest = PackManifest.fromJson(json);
          final validation = await _validator.validateManifest(
            manifest,
            folderPath: directory.path,
            mode: PackValidationMode.draft,
          );
          if (validation.isFailure) {
            continue;
          }
          final normalized = validation.valueOrNull!;
          if (loaded.containsKey(normalized.id)) {
            continue;
          }
          loaded[normalized.id] = StickerPack.fromManifest(
            normalized,
            directory.path,
          );
        } on Object {
          continue;
        }
      }

      _packs
        ..clear()
        ..addAll(loaded);
      _loaded = true;
      return AppResult.success(_sortedPacks());
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedReadLocalPacks,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<AppResult<StickerPack>> createPack({
    required String name,
    required String publisher,
    String? packId,
  }) async {
    await _ensureLoaded();
    final id = packId == null
        ? LibraryIds.newPackId(name)
        : LibraryIds.sanitize(packId);
    if (_packs.containsKey(id)) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packIdAlreadyExists),
      );
    }
    final packDirectory = await _appDirs.pack(id);
    final manifest = PackManifest(
      id: id,
      name: name,
      publisher: publisher,
      tray: '',
      source: PackSource.custom,
      version: 1,
    );
    final validation = await _validator.validateManifest(
      manifest,
      folderPath: packDirectory.path,
      mode: PackValidationMode.draft,
    );
    if (validation.isFailure) {
      return AppResult.failure(validation.errorOrNull!);
    }
    try {
      await _saveManifest(packDirectory.path, validation.valueOrNull!);
      final pack = StickerPack.fromManifest(
        validation.valueOrNull!,
        packDirectory.path,
      );
      _packs[pack.id] = pack;
      return AppResult.success(pack);
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedCreatePack,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<AppResult<StickerPack>> updatePackMetadata({
    required String packId,
    required String name,
    required String publisher,
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }
    final manifest = pack.toManifest().copyWith(
      name: name,
      publisher: publisher,
      version: pack.version + 1,
    );
    return _savePack(pack.folderPath, manifest);
  }

  Future<AppResult<StickerPack>> addSticker({
    required String packId,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
    List<String> emojis = const <String>[],
    String accessibilityText = '',
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }
    if (pack.stickers.length >= PackRules.maxStickers) {
      await _cleanupOperationPath(result.outputPath);
      return AppResult.failure(
        const AppError.validation(
          message: PackMessages.maxLocalStickersReached,
        ),
      );
    }

    final fileName = _nextStickerFileName(pack);
    final destinationPath = p.join(pack.folderPath, fileName);
    final editableBackups = await _backupEditableSidecars(
      folderPath: pack.folderPath,
      targetFileName: fileName,
    );
    var writtenEditablePaths = const <String>[];
    try {
      await _fileOps.moveFile(result.outputPath, destinationPath);
      writtenEditablePaths = await _writeEditableSidecars(
        folderPath: pack.folderPath,
        targetFileName: fileName,
        backupPaths: editableBackups,
        editableSourcePath: editableSourcePath,
        editStateJson: editStateJson,
      );
      final manifest = pack.toManifest().copyWith(
        stickers: <StickerItem>[
          ...pack.stickers,
          StickerItem(
            file: fileName,
            emojis: emojis,
            accessibilityText: accessibilityText,
          ),
        ],
        version: pack.version + 1,
      );
      final saved = await _savePack(pack.folderPath, manifest);
      if (saved.isFailure) {
        await _fileOps.deleteFileIfExists(destinationPath);
        await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      } else {
        await _clearEditableSidecarBackups(editableBackups);
      }
      return saved;
    } on FileSystemException catch (error) {
      await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedAddSticker,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    } finally {
      await _cleanupOperationPath(result.outputPath);
    }
  }

  Future<AppResult<StickerPack>> setTray({
    required String packId,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }

    final trayPath = p.join(pack.folderPath, PackFiles.trayFileName);
    final backupPath = PackFiles.backupPath(
      trayPath,
      LibraryIds.newOperationId(),
    );
    final editableBackups = await _backupEditableSidecars(
      folderPath: pack.folderPath,
      targetFileName: PackFiles.trayFileName,
    );
    var writtenEditablePaths = const <String>[];
    try {
      if (await _fileOps.fileExists(trayPath)) {
        await _fileOps.moveFile(trayPath, backupPath);
      }
      await _fileOps.moveFile(result.outputPath, trayPath);
      writtenEditablePaths = await _writeEditableSidecars(
        folderPath: pack.folderPath,
        targetFileName: PackFiles.trayFileName,
        backupPaths: editableBackups,
        editableSourcePath: editableSourcePath,
        editStateJson: editStateJson,
      );
      final manifest = pack.toManifest().copyWith(
        tray: PackFiles.trayFileName,
        version: pack.version + 1,
      );
      final saved = await _savePack(pack.folderPath, manifest);
      if (saved.isSuccess) {
        await _fileOps.deleteFileIfExists(backupPath);
        await _clearEditableSidecarBackups(editableBackups);
      } else {
        await _fileOps.deleteFileIfExists(trayPath);
        if (await _fileOps.fileExists(backupPath)) {
          await _fileOps.moveFile(backupPath, trayPath);
        }
        await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      }
      return saved;
    } on FileSystemException catch (error) {
      if (await _fileOps.fileExists(backupPath) &&
          !await _fileOps.fileExists(trayPath)) {
        await _fileOps.moveFile(backupPath, trayPath);
      }
      await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedUpdateTray,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    } finally {
      await _cleanupOperationPath(result.outputPath);
    }
  }

  Future<AppResult<StickerPack>> removeSticker({
    required String packId,
    required String fileName,
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }
    final updatedStickers = pack.stickers
        .where((item) => item.file != fileName)
        .toList();
    if (updatedStickers.length == pack.stickers.length) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.stickerNotFound),
      );
    }
    final manifest = pack.toManifest().copyWith(
      stickers: updatedStickers,
      version: pack.version + 1,
    );
    final saved = await _savePack(pack.folderPath, manifest);
    if (saved.isSuccess) {
      await _fileOps.deleteFileIfExists(p.join(pack.folderPath, fileName));
      await _deleteEditableSidecars(
        folderPath: pack.folderPath,
        targetFileName: fileName,
      );
    }
    return saved;
  }

  Future<AppResult<StickerPack>> replaceSticker({
    required String packId,
    required String fileName,
    required ProcessResult result,
    String? editableSourcePath,
    String? editStateJson,
    List<String>? emojis,
    String? accessibilityText,
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      await _cleanupOperationPath(result.outputPath);
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }

    final stickerIndex = pack.stickers.indexWhere(
      (sticker) => sticker.file == fileName,
    );
    if (stickerIndex == -1) {
      await _cleanupOperationPath(result.outputPath);
      return AppResult.failure(
        const AppError.validation(message: PackMessages.stickerNotFound),
      );
    }

    final destinationPath = p.join(pack.folderPath, fileName);
    final backupPath = PackFiles.backupPath(
      destinationPath,
      LibraryIds.newOperationId(),
    );
    final editableBackups = await _backupEditableSidecars(
      folderPath: pack.folderPath,
      targetFileName: fileName,
    );
    var writtenEditablePaths = const <String>[];
    final currentSticker = pack.stickers[stickerIndex];

    try {
      if (await _fileOps.fileExists(destinationPath)) {
        await _fileOps.moveFile(destinationPath, backupPath);
      }
      await _fileOps.moveFile(
        result.outputPath,
        destinationPath,
        replace: true,
      );
      writtenEditablePaths = await _writeEditableSidecars(
        folderPath: pack.folderPath,
        targetFileName: fileName,
        backupPaths: editableBackups,
        editableSourcePath: editableSourcePath,
        editStateJson: editStateJson,
      );

      final updatedStickers = List<StickerItem>.from(pack.stickers);
      updatedStickers[stickerIndex] = currentSticker.copyWith(
        emojis: emojis ?? currentSticker.emojis,
        accessibilityText:
            accessibilityText ?? currentSticker.accessibilityText,
      );

      final manifest = pack.toManifest().copyWith(
        stickers: updatedStickers,
        version: pack.version + 1,
      );
      final saved = await _savePack(pack.folderPath, manifest);
      if (saved.isSuccess) {
        await _fileOps.deleteFileIfExists(backupPath);
        await _clearEditableSidecarBackups(editableBackups);
      } else {
        await _fileOps.deleteFileIfExists(destinationPath);
        if (await _fileOps.fileExists(backupPath)) {
          await _fileOps.moveFile(backupPath, destinationPath, replace: true);
        }
        await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      }
      return saved;
    } on FileSystemException catch (error) {
      if (await _fileOps.fileExists(backupPath) &&
          !await _fileOps.fileExists(destinationPath)) {
        await _fileOps.moveFile(backupPath, destinationPath, replace: true);
      }
      await _rollbackEditableSidecars(editableBackups, writtenEditablePaths);
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedReplaceSticker,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    } finally {
      await _cleanupOperationPath(result.outputPath);
    }
  }

  Future<AppResult<void>> deletePack(String packId) async {
    final pack = _packs[packId];
    if (pack == null) {
      return const AppResult.success(null);
    }
    try {
      await _fileOps.deleteDirectoryIfExists(pack.folderPath);
      _packs.remove(packId);
      return const AppResult.success(null);
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedDeletePack,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<AppResult<StickerPack>> validatePack(
    String packId, {
    PackValidationMode mode = PackValidationMode.export,
  }) async {
    final pack = _packs[packId];
    if (pack == null) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.packNotFound),
      );
    }
    return _validator.validatePack(pack, mode: mode);
  }

  Future<AppResult<StickerPack>> installDownloadedPack({
    required String extractedDirPath,
    required String expectedRemoteId,
    required int expectedVersion,
  }) async {
    await _ensureLoaded();
    final manifestPath = p.join(extractedDirPath, PackFiles.manifestFileName);
    try {
      final json = await _jsonStore.readMap(manifestPath);
      final manifest = PackManifest.fromJson(json);
      final validation = await _validator.validateManifest(
        manifest,
        folderPath: extractedDirPath,
        mode: PackValidationMode.install,
      );
      if (validation.isFailure) {
        return AppResult.failure(validation.errorOrNull!);
      }

      final normalized = validation.valueOrNull!;
      if (normalized.source != PackSource.remote ||
          normalized.remoteId == null) {
        return AppResult.failure(
          const AppError.invalidPack(
            message: PackMessages.downloadedPackMustBeRemote,
          ),
        );
      }
      if (normalized.id != expectedRemoteId ||
          normalized.remoteId != expectedRemoteId) {
        return AppResult.failure(
          const AppError.invalidPack(
            message: PackMessages.downloadedPackIdMismatch,
          ),
        );
      }
      if (normalized.version != expectedVersion) {
        return AppResult.failure(
          const AppError.invalidPack(
            message: PackMessages.downloadedPackVersionMismatch,
          ),
        );
      }

      final existingRemote = _packs.values
          .where((pack) => pack.remoteId == normalized.remoteId)
          .cast<StickerPack?>()
          .firstWhere((pack) => pack != null, orElse: () => null);
      if (existingRemote != null) {
        if (existingRemote.version == normalized.version) {
          return AppResult.success(existingRemote);
        }
        if (existingRemote.version > normalized.version) {
          return AppResult.failure(
            const AppError.validation(
              message: PackMessages.newerRemoteAlreadyInstalled,
            ),
          );
        }
      }
      if (_packs.containsKey(normalized.id) &&
          _packs[normalized.id]?.remoteId != normalized.remoteId) {
        return AppResult.failure(
          const AppError.validation(message: PackMessages.packIdExistsLocally),
        );
      }

      await _saveManifest(extractedDirPath, normalized);

      final finalDirectory = p.join(
        (await _appDirs.packs()).path,
        normalized.id,
      );
      if (existingRemote == null) {
        await _fileOps.replaceDirectory(extractedDirPath, finalDirectory);
      } else {
        await _fileOps.replaceDirectory(
          extractedDirPath,
          existingRemote.folderPath,
        );
      }

      final installedFolder = existingRemote?.folderPath ?? finalDirectory;
      final installedPack = StickerPack.fromManifest(
        normalized,
        installedFolder,
      );
      if (existingRemote != null && existingRemote.id != installedPack.id) {
        _packs.remove(existingRemote.id);
      }
      _packs[installedPack.id] = installedPack;
      return AppResult.success(installedPack);
    } on FormatException catch (error) {
      return AppResult.failure(
        AppError.parse(
          message: PackMessages.downloadedManifestInvalid,
          debugDetails: error.toString(),
        ),
      );
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedInstallDownloadedPack,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<AppResult<StickerPack>> installImportedPack({
    required String extractedDirPath,
  }) async {
    await _ensureLoaded();
    final manifestPath = p.join(extractedDirPath, PackFiles.manifestFileName);
    try {
      final json = await _jsonStore.readMap(manifestPath);
      var manifest = PackManifest.fromJson(json);
      var validation = await _validator.validateManifest(
        manifest,
        folderPath: extractedDirPath,
        mode: PackValidationMode.install,
      );
      if (validation.isFailure) {
        return AppResult.failure(validation.errorOrNull!);
      }

      manifest = validation.valueOrNull!;
      if (manifest.source != PackSource.custom || manifest.remoteId != null) {
        return AppResult.failure(
          const AppError.invalidPack(
            message: PackMessages.importedPackMustBeLocal,
          ),
        );
      }

      var localId = manifest.id;
      while (_packs.containsKey(localId)) {
        localId = LibraryIds.newPackId(manifest.name);
      }
      if (localId != manifest.id) {
        manifest = manifest.copyWith(id: localId);
        validation = await _validator.validateManifest(
          manifest,
          folderPath: extractedDirPath,
          mode: PackValidationMode.install,
        );
        if (validation.isFailure) {
          return AppResult.failure(validation.errorOrNull!);
        }
        manifest = validation.valueOrNull!;
      }

      await _saveManifest(extractedDirPath, manifest);
      final finalDirectory = p.join((await _appDirs.packs()).path, manifest.id);
      await _fileOps.replaceDirectory(extractedDirPath, finalDirectory);
      final pack = StickerPack.fromManifest(manifest, finalDirectory);
      _packs[pack.id] = pack;
      return AppResult.success(pack);
    } on FormatException catch (error) {
      return AppResult.failure(
        AppError.parse(
          message: PackMessages.importedManifestInvalid,
          debugDetails: error.toString(),
        ),
      );
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedImportPack,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<void> _ensureLoaded() async {
    if (_loaded) {
      return;
    }
    await loadPacks();
  }

  Future<Map<String, String>> _backupEditableSidecars({
    required String folderPath,
    required String targetFileName,
  }) async {
    final backups = <String, String>{};
    final directory = Directory(folderPath);
    if (!await directory.exists()) {
      return backups;
    }

    final sourcePrefix = '${PackFiles.editableSourcePrefix(targetFileName)}.';
    final editStateName = PackFiles.editStateFileName(targetFileName);
    await for (final entity in directory.list(followLinks: false)) {
      if (entity is! File) {
        continue;
      }
      final name = p.basename(entity.path);
      final isEditableSource = name.startsWith(sourcePrefix);
      if (!isEditableSource && name != editStateName) {
        continue;
      }

      final backupPath = PackFiles.backupPath(
        entity.path,
        LibraryIds.newOperationId(),
      );
      await _fileOps.moveFile(entity.path, backupPath, replace: true);
      backups[entity.path] = backupPath;
    }

    return backups;
  }

  Future<List<String>> _writeEditableSidecars({
    required String folderPath,
    required String targetFileName,
    required Map<String, String> backupPaths,
    String? editableSourcePath,
    String? editStateJson,
  }) async {
    final writtenPaths = <String>[];

    if (editableSourcePath != null && editableSourcePath.isNotEmpty) {
      var extension = p.extension(editableSourcePath).toLowerCase();
      if (extension.isEmpty || extension.length > 10) {
        extension = '.png';
      }

      final sourceDestinationPath = p.join(
        folderPath,
        PackFiles.editableSourceFileName(targetFileName, extension),
      );
      final sourceInputPath =
          backupPaths[editableSourcePath] ?? editableSourcePath;

      if (p.normalize(sourceInputPath) != p.normalize(sourceDestinationPath) ||
          !await _fileOps.fileExists(sourceDestinationPath)) {
        await _fileOps.copyFile(sourceInputPath, sourceDestinationPath);
      }
      writtenPaths.add(sourceDestinationPath);
    }

    final editStatePath = p.join(
      folderPath,
      PackFiles.editStateFileName(targetFileName),
    );
    if (editStateJson != null && editStateJson.isNotEmpty) {
      await _fileOps.writeStringAtomic(editStatePath, editStateJson);
      writtenPaths.add(editStatePath);
    }

    return writtenPaths;
  }

  Future<void> _rollbackEditableSidecars(
    Map<String, String> backupPaths,
    List<String> writtenPaths,
  ) async {
    for (final path in writtenPaths) {
      await _fileOps.deleteFileIfExists(path);
    }
    for (final entry in backupPaths.entries) {
      if (await _fileOps.fileExists(entry.value)) {
        await _fileOps.moveFile(entry.value, entry.key, replace: true);
      }
    }
  }

  Future<void> _clearEditableSidecarBackups(
    Map<String, String> backupPaths,
  ) async {
    for (final path in backupPaths.values) {
      await _fileOps.deleteFileIfExists(path);
    }
  }

  Future<void> _deleteEditableSidecars({
    required String folderPath,
    required String targetFileName,
  }) async {
    final directory = Directory(folderPath);
    if (!await directory.exists()) {
      return;
    }

    final sourcePrefix = '${PackFiles.editableSourcePrefix(targetFileName)}.';
    final editStateName = PackFiles.editStateFileName(targetFileName);
    await for (final entity in directory.list(followLinks: false)) {
      if (entity is! File) {
        continue;
      }
      final name = p.basename(entity.path);
      if (name.startsWith(sourcePrefix) || name == editStateName) {
        await _fileOps.deleteFileIfExists(entity.path);
      }
    }
  }

  Future<AppResult<StickerPack>> _savePack(
    String folderPath,
    PackManifest manifest,
  ) async {
    final validation = await _validator.validateManifest(
      manifest,
      folderPath: folderPath,
      mode: PackValidationMode.draft,
    );
    if (validation.isFailure) {
      return AppResult.failure(validation.errorOrNull!);
    }
    try {
      await _saveManifest(folderPath, validation.valueOrNull!);
      final pack = StickerPack.fromManifest(
        validation.valueOrNull!,
        folderPath,
      );
      _packs[pack.id] = pack;
      return AppResult.success(pack);
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedSaveManifest,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<void> _saveManifest(String folderPath, PackManifest manifest) async {
    await _fileOps.ensureDirectory(folderPath);
    await _jsonStore.writeMap(
      p.join(folderPath, PackFiles.manifestFileName),
      manifest.toJson(),
    );
  }

  List<StickerPack> _sortedPacks() {
    final packs = _packs.values.toList(growable: false);
    packs.sort((left, right) {
      final byName = left.name.toLowerCase().compareTo(
        right.name.toLowerCase(),
      );
      if (byName != 0) {
        return byName;
      }
      return left.id.compareTo(right.id);
    });
    return packs;
  }

  String _nextStickerFileName(StickerPack pack) {
    final indices = pack.stickers
        .map(
          (item) =>
              RegExp(PackPatterns.stickerFileNameCapture).firstMatch(item.file),
        )
        .whereType<RegExpMatch>()
        .map((match) => int.tryParse(match.group(1) ?? '0') ?? 0)
        .toList(growable: false);
    final nextIndex = indices.isEmpty ? 1 : indices.reduce(max) + 1;
    return PackFiles.stickerFileName(nextIndex);
  }

  Future<void> _cleanupOperationPath(String path) async {
    final parent = p.dirname(path);
    final tempRoot = (await _appDirs.temp()).path;
    if (p.isWithin(tempRoot, parent) ||
        p.normalize(tempRoot) == p.normalize(parent)) {
      await _fileOps.deleteDirectoryIfExists(parent);
    }
  }
}
