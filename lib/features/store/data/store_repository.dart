import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../../core/util/mime.dart';
import '../../editor/data/webp_encoder.dart';
import '../../library/data/io/file_ops.dart';
import '../../library/data/io/json_store.dart';
import '../../library/data/io/library_dirs.dart';
import '../../library/data/pack_store.dart';
import '../../library/domain/pack_models.dart';
import '../../library/domain/pack_validator.dart';
import '../../library/util/library_ids.dart';
import '../domain/store_models.dart';
import 'store_mapper.dart';
import 'store_remote_source.dart';

class StoreRepository {
  StoreRepository(
    this._remoteSource,
    this._mapper,
    this._packStore,
    this._appDirs,
    this._fileOps,
    this._jsonStore,
    this._validator,
    this._encoder, {
    int metadataConcurrency = 4,
    int assetConcurrency = 3,
  }) : _metadataConcurrency = metadataConcurrency < 1 ? 1 : metadataConcurrency,
       _assetConcurrency = assetConcurrency < 1 ? 1 : assetConcurrency;

  final StoreRemoteSource _remoteSource;
  final StoreMapper _mapper;
  final PackStore _packStore;
  final LibraryDirs _appDirs;
  final FileOps _fileOps;
  final JsonStore _jsonStore;
  final PackValidator _validator;
  final WebpEncoder _encoder;
  final int _metadataConcurrency;
  final int _assetConcurrency;

  StoreCatalog? _catalog;
  StoreCatalogSnapshot? _snapshot;
  final Map<String, StoreRemoteFileInfo> _fileInfoCache =
      <String, StoreRemoteFileInfo>{};

  StoreCatalog? get cachedCatalog => _catalog;

  StoreCatalogSnapshot? get snapshot => _snapshot;

  Future<AppResult<StoreCatalogSnapshot>> refreshCatalog({
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteSource.fetchCatalog(cancelToken: cancelToken);
    if (result.isFailure) {
      return AppResult.failure(result.errorOrNull!);
    }
    _catalog = result.valueOrNull!;
    return _buildSnapshot(_catalog!);
  }

  Future<AppResult<StoreCatalogSnapshot>> refreshLocalStatus() async {
    final catalog = _catalog;
    if (catalog == null) {
      return AppResult.failure(
        AppError.validation(
          message: StoreMessages.catalogNotLoaded,
          code: StoreCodes.catalogNotLoaded,
        ),
      );
    }
    return _buildSnapshot(catalog);
  }

  Future<AppResult<StorePackDetail>> resolvePackDetail(
    String packId, {
    CancelToken? cancelToken,
  }) async {
    final snapshotResult = await _ensureSnapshot();
    if (snapshotResult.isFailure) {
      return AppResult.failure(snapshotResult.errorOrNull!);
    }
    final detail = snapshotResult.valueOrNull!.packDetails[packId];
    if (detail == null) {
      return AppResult.failure(
        AppError.validation(
          message: StoreMessages.packNotFound,
          code: StoreCodes.packNotFound,
        ),
      );
    }

    if (detail.remote.thumbnailFileId case final thumbnailFileId?) {
      final controller = _StoreRequestController(cancelToken, _mapper, packId);
      if (controller.isCancelled) {
        return AppResult.failure(
          controller.cancelledError(StoreOperationScope.detail),
        );
      }
      final thumbnailResult = await _loadFileInfo(
        _StoreRemoteAssetDescriptor(
          index: -1,
          fileId: thumbnailFileId,
          outputFileName: '',
          kind: _StoreRemoteAssetKind.thumbnail,
        ),
        controller: controller,
        scope: StoreOperationScope.detail,
      );
      if (thumbnailResult.isFailure) {
        return AppResult.failure(thumbnailResult.errorOrNull!);
      }
    }

    return AppResult.success(detail);
  }

  Future<AppResult<StorePackDetail>> downloadPack(
    String packId, {
    CancelToken? cancelToken,
    void Function(StoreDownloadProgress progress)? onProgress,
  }) async {
    final snapshotResult = await _ensureSnapshot();
    if (snapshotResult.isFailure) {
      return AppResult.failure(snapshotResult.errorOrNull!);
    }

    final detail = snapshotResult.valueOrNull!.packDetails[packId];
    if (detail == null) {
      return AppResult.failure(
        AppError.validation(
          message: StoreMessages.packNotFound,
          code: StoreCodes.packNotFound,
        ),
      );
    }

    final remotePack = detail.remote;
    final localStatus = detail.localStatus;
    if (localStatus.installed &&
        localStatus.valid &&
        localStatus.sameVersionInstalled) {
      return AppResult.success(detail);
    }
    if ((localStatus.localVersion ?? 0) > remotePack.version &&
        localStatus.valid) {
      return AppResult.failure(
        _mapper.toAppError(
          StoreFailure(
            type: StoreFailureType.outdatedLocalVersion,
            scope: StoreOperationScope.download,
            message: StoreMessages.outdatedLocalVersion,
            code: StoreCodes.outdatedLocalVersion,
            retryable: false,
            packId: packId,
          ),
        ),
      );
    }

    final controller = _StoreRequestController(cancelToken, _mapper, packId);
    if (controller.isCancelled) {
      return AppResult.failure(
        controller.cancelledError(StoreOperationScope.download),
      );
    }

    final operationDir = await _appDirs.operation(LibraryIds.newOperationId());
    final stagedDir = Directory(
      p.join(operationDir.path, PackFiles.extractedPackDirectoryName),
    );

    try {
      final planResult = await _buildDownloadPlan(
        remotePack,
        controller: controller,
      );
      if (planResult.isFailure) {
        return AppResult.failure(planResult.errorOrNull!);
      }

      final plans = planResult.valueOrNull!;
      final progress = _StoreProgressTracker(
        packId: packId,
        plans: plans,
        onProgress: onProgress,
      );

      onProgress?.call(
        StoreDownloadProgress(
          packId: packId,
          totalBytes: progress.totalBytes,
          totalAssets: plans.length,
        ),
      );

      await _fileOps.ensureDirectory(stagedDir.path);
      final downloadedAssetsResult =
          await _runBoundedResults<_StoreAssetPlan, _StoreDownloadedAsset>(
            plans,
            concurrency: _assetConcurrency,
            onFailure: controller.cancelOutstanding,
            task: (asset) => _downloadAsset(
              remotePack: remotePack,
              asset: asset,
              stagedDirPath: stagedDir.path,
              controller: controller,
              progress: progress,
            ),
          );
      if (downloadedAssetsResult.isFailure) {
        return AppResult.failure(downloadedAssetsResult.errorOrNull!);
      }

      final stickerItems = downloadedAssetsResult.valueOrNull!
          .where((asset) => asset.isSticker)
          .map((asset) => StickerItem(file: asset.outputFileName))
          .toList(growable: false);

      final manifest = PackManifest(
        id: remotePack.id,
        name: remotePack.name,
        publisher: remotePack.publisher,
        animated: remotePack.animated,
        tray: PackFiles.trayFileName,
        source: PackSource.remote,
        remoteId: remotePack.id,
        version: remotePack.version,
        stickers: stickerItems,
      );

      await _jsonStore.writeMap(
        p.join(stagedDir.path, PackFiles.manifestFileName),
        manifest.toJson(),
      );

      final installResult = await _packStore.installDownloadedPack(
        extractedDirPath: stagedDir.path,
        expectedRemoteId: remotePack.id,
        expectedVersion: remotePack.version,
      );
      if (installResult.isFailure) {
        return AppResult.failure(installResult.errorOrNull!);
      }

      final updatedSnapshot = await _buildSnapshot(_catalog!);
      if (updatedSnapshot.isFailure) {
        return AppResult.failure(updatedSnapshot.errorOrNull!);
      }

      final updatedDetail = updatedSnapshot.valueOrNull!.packDetails[packId];
      if (updatedDetail == null) {
        return AppResult.failure(
          AppError.unknown(
            message: StoreMessages.downloadedPackUnresolved,
            code: StoreCodes.installResolutionFailed,
          ),
        );
      }

      return AppResult.success(updatedDetail);
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: StoreMessages.downloadedPackStorageFailed,
          path: error.path,
          code: StoreCodes.insufficientStorage,
          debugDetails: error.toString(),
        ),
      );
    } finally {
      controller.cancelOutstanding();
      await _fileOps.deleteDirectoryIfExists(operationDir.path);
    }
  }

  Future<AppResult<StoreCatalogSnapshot>> _ensureSnapshot() async {
    final cached = _snapshot;
    if (cached != null) {
      return AppResult.success(cached);
    }
    final catalog = _catalog;
    if (catalog == null) {
      return refreshCatalog();
    }
    return _buildSnapshot(catalog);
  }

  Future<AppResult<StoreCatalogSnapshot>> _buildSnapshot(
    StoreCatalog catalog,
  ) async {
    final inventoryResult = await _loadLocalInventory();
    if (inventoryResult.isFailure) {
      return AppResult.failure(inventoryResult.errorOrNull!);
    }

    final inventory = inventoryResult.valueOrNull!;
    final localStatuses = <String, StoreLocalPackStatus>{};
    final packDetails = <String, StorePackDetail>{};

    for (final pack in catalog.packs) {
      final validLocal = inventory.validByRemoteId[pack.id];
      final invalidLocal = inventory.invalidByRemoteId[pack.id];
      final localVersion = validLocal?.version ?? invalidLocal?.version;
      final sameVersionInstalled =
          validLocal != null && validLocal.version == pack.version;
      final updateAvailable =
          validLocal != null && validLocal.version < pack.version;
      final repairAvailable = invalidLocal != null;

      final status = StoreLocalPackStatus(
        remotePackId: pack.id,
        localPackId: validLocal?.id ?? invalidLocal?.id,
        localVersion: localVersion,
        installed: validLocal != null || invalidLocal != null,
        valid: validLocal != null,
        sameVersionInstalled: sameVersionInstalled,
        updateAvailable: updateAvailable,
        repairAvailable: repairAvailable,
      );

      localStatuses[pack.id] = status;
      packDetails[pack.id] = StorePackDetail(
        remote: pack,
        localStatus: status,
        localPack: validLocal,
      );
    }

    final snapshot = StoreCatalogSnapshot(
      catalog: catalog,
      localStatuses: localStatuses,
      packDetails: packDetails,
    );
    _snapshot = snapshot;
    return AppResult.success(snapshot);
  }

  Future<AppResult<List<_StoreAssetPlan>>> _buildDownloadPlan(
    StoreRemotePack pack, {
    required _StoreRequestController controller,
  }) async {
    final descriptors = <_StoreRemoteAssetDescriptor>[
      _StoreRemoteAssetDescriptor(
        index: 0,
        fileId: pack.trayFileId,
        outputFileName: PackFiles.trayFileName,
        kind: _StoreRemoteAssetKind.tray,
      ),
      ...pack.stickerFileIds.indexed.map(
        (entry) => _StoreRemoteAssetDescriptor(
          index: entry.$1 + 1,
          fileId: entry.$2,
          outputFileName: PackFiles.stickerFileName(entry.$1 + 1),
          kind: _StoreRemoteAssetKind.sticker,
        ),
      ),
    ];

    final infosResult =
        await _runBoundedResults<
          _StoreRemoteAssetDescriptor,
          StoreRemoteFileInfo
        >(
          descriptors,
          concurrency: _metadataConcurrency,
          onFailure: controller.cancelOutstanding,
          task: (descriptor) => _loadFileInfo(
            descriptor,
            controller: controller,
            scope: StoreOperationScope.download,
          ),
        );
    if (infosResult.isFailure) {
      return AppResult.failure(infosResult.errorOrNull!);
    }

    final infos = infosResult.valueOrNull!;
    return AppResult.success(
      List<_StoreAssetPlan>.generate(
        descriptors.length,
        (index) => _StoreAssetPlan(
          descriptor: descriptors[index],
          fileInfo: infos[index],
        ),
        growable: false,
      ),
    );
  }

  Future<AppResult<StoreRemoteFileInfo>> _loadFileInfo(
    _StoreRemoteAssetDescriptor descriptor, {
    required _StoreRequestController controller,
    required StoreOperationScope scope,
  }) async {
    final cached = _fileInfoCache[descriptor.fileId];
    if (cached != null) {
      return AppResult.success(cached);
    }

    if (controller.isCancelled) {
      return AppResult.failure(controller.cancelledError(scope));
    }

    final result = await _remoteSource.fetchFileInfo(
      descriptor.fileId,
      cancelToken: controller.branch(),
    );
    if (result.isFailure) {
      return AppResult.failure(
        _mapMissingAssetFailure(
          descriptor,
          scope: scope,
          sourceError: result.errorOrNull!,
          packId: controller.packId,
        ),
      );
    }

    final fileInfo = result.valueOrNull!;
    _fileInfoCache[descriptor.fileId] = fileInfo;
    return AppResult.success(fileInfo);
  }

  Future<AppResult<_StoreDownloadedAsset>> _downloadAsset({
    required StoreRemotePack remotePack,
    required _StoreAssetPlan asset,
    required String stagedDirPath,
    required _StoreRequestController controller,
    required _StoreProgressTracker progress,
  }) async {
    if (controller.isCancelled) {
      return AppResult.failure(
        controller.cancelledError(StoreOperationScope.download),
      );
    }

    final rawPath = p.join(
      stagedDirPath,
      PackFiles.rawFilePath(asset.outputFileName),
    );
    final outputPath = p.join(stagedDirPath, asset.outputFileName);
    final downloadResult = await _remoteSource.downloadFile(
      fileId: asset.fileInfo.fileId,
      destinationPath: rawPath,
      cancelToken: controller.branch(),
      onReceiveProgress: (received, _) {
        progress.update(asset.fileInfo.fileId, received);
      },
    );
    if (downloadResult.isFailure) {
      return AppResult.failure(
        _mapMissingAssetFailure(
          asset.descriptor,
          scope: StoreOperationScope.download,
          sourceError: downloadResult.errorOrNull!,
          packId: remotePack.id,
        ),
      );
    }

    final actualBytes = await File(rawPath).length();
    if (asset.fileInfo.sizeBytes > 0 &&
        actualBytes != asset.fileInfo.sizeBytes) {
      return AppResult.failure(
        _mapper.toAppError(
          StoreFailure(
            type: StoreFailureType.partialDownload,
            scope: StoreOperationScope.download,
            message: StoreMessages.partialDownload,
            code: StoreCodes.partialDownload,
            retryable: true,
            packId: remotePack.id,
            fileId: asset.fileInfo.fileId,
            reasons: <String>[
              StoreMessages.expectedBytes(
                asset.fileInfo.sizeBytes,
                actualBytes,
              ),
            ],
          ),
        ),
      );
    }

    final rawBytes = await File(rawPath).readAsBytes();
    final mimeType = _detectRemoteMime(asset.fileInfo.mimeType, rawBytes);
    if (mimeType == ImageMimeType.gif) {
      return AppResult.failure(
        _mapper.toAppError(
          StoreFailure(
            type: StoreFailureType.unsupportedFormat,
            scope: StoreOperationScope.download,
            message: StoreMessages.gifNotSupported,
            code: StoreCodes.unsupportedFormat,
            retryable: false,
            packId: remotePack.id,
            fileId: asset.fileInfo.fileId,
          ),
        ),
      );
    }

    if (mimeType == ImageMimeType.webp) {
      final validationMessage = await _validateAssetBytes(
        bytes: rawBytes,
        animatedPack: remotePack.animated,
        isSticker: asset.isSticker,
      );
      if (validationMessage != null) {
        return AppResult.failure(
          _corruptAssetError(
            remotePackId: remotePack.id,
            fileId: asset.fileInfo.fileId,
            message: validationMessage,
          ),
        );
      }
      await _fileOps.moveFile(rawPath, outputPath, replace: true);
    } else if (mimeType == ImageMimeType.png ||
        mimeType == ImageMimeType.jpeg) {
      if (remotePack.animated) {
        return AppResult.failure(
          _mapper.toAppError(
            StoreFailure(
              type: StoreFailureType.unsupportedFormat,
              scope: StoreOperationScope.download,
              message: StoreMessages.animatedPackRequiresWebp,
              code: StoreCodes.unsupportedFormat,
              retryable: false,
              packId: remotePack.id,
              fileId: asset.fileInfo.fileId,
            ),
          ),
        );
      }
      final encoded = await _encoder.encodeWebp(
        bytes: rawBytes,
        quality: mimeType == ImageMimeType.png ? 100 : 95,
        lossless: mimeType == ImageMimeType.png,
      );
      final validationMessage = await _validateAssetBytes(
        bytes: encoded,
        animatedPack: false,
        isSticker: asset.isSticker,
      );
      if (validationMessage != null) {
        return AppResult.failure(
          _corruptAssetError(
            remotePackId: remotePack.id,
            fileId: asset.fileInfo.fileId,
            message: validationMessage,
          ),
        );
      }
      await _fileOps.writeBytesAtomic(outputPath, encoded);
      await _fileOps.deleteFileIfExists(rawPath);
    } else {
      return AppResult.failure(
        _corruptAssetError(
          remotePackId: remotePack.id,
          fileId: asset.fileInfo.fileId,
          message: StoreMessages.corruptAsset,
        ),
      );
    }

    progress.complete(asset.fileInfo.fileId, asset.fileInfo.sizeBytes);
    return AppResult.success(
      _StoreDownloadedAsset(
        outputFileName: asset.outputFileName,
        isSticker: asset.isSticker,
      ),
    );
  }

  AppError _mapMissingAssetFailure(
    _StoreRemoteAssetDescriptor descriptor, {
    required StoreOperationScope scope,
    required AppError sourceError,
    required String? packId,
  }) {
    final failure = _mapper.failureFromAppError(
      sourceError,
      scope: scope,
      packId: packId,
    );
    if (failure.type != StoreFailureType.notFound) {
      return sourceError;
    }

    final (message, code) = switch (descriptor.kind) {
      _StoreRemoteAssetKind.thumbnail => (
        StoreMessages.missingThumbnail,
        StoreCodes.missingThumbnail,
      ),
      _StoreRemoteAssetKind.tray => (
        StoreMessages.missingTray,
        StoreCodes.missingTray,
      ),
      _StoreRemoteAssetKind.sticker => (
        StoreMessages.missingSticker,
        StoreCodes.missingSticker,
      ),
    };

    return _mapper.toAppError(
      StoreFailure(
        type: StoreFailureType.missingFile,
        scope: scope,
        message: message,
        code: code,
        retryable: true,
        packId: packId,
        fileId: descriptor.fileId,
        reasons: sourceError.reasons,
      ),
    );
  }

  AppError _corruptAssetError({
    required String remotePackId,
    required String fileId,
    required String message,
  }) {
    return _mapper.toAppError(
      StoreFailure(
        type: StoreFailureType.corruptAsset,
        scope: StoreOperationScope.download,
        message: message,
        code: StoreCodes.corruptAsset,
        retryable: true,
        packId: remotePackId,
        fileId: fileId,
        reasons: <String>[message],
      ),
    );
  }

  Future<String?> _validateAssetBytes({
    required Uint8List bytes,
    required bool animatedPack,
    required bool isSticker,
  }) async {
    return Isolate.run<String?>(
      () => _validateAssetBytesInBackground(
        _AssetBytesValidationInput(
          bytes: bytes,
          animatedPack: animatedPack,
          isSticker: isSticker,
        ),
      ),
    );
  }

  Future<AppResult<List<T>>> _runBoundedResults<I, T>(
    List<I> items, {
    required int concurrency,
    required Future<AppResult<T>> Function(I item) task,
    required void Function() onFailure,
  }) async {
    if (items.isEmpty) {
      return AppResult.success(<T>[]);
    }

    final results = List<T?>.filled(items.length, null);
    AppError? failure;
    var nextIndex = 0;

    Future<void> worker() async {
      while (failure == null) {
        final currentIndex = nextIndex;
        if (currentIndex >= items.length) {
          return;
        }
        nextIndex += 1;
        final result = await task(items[currentIndex]);
        if (result.isFailure) {
          failure = result.errorOrNull!;
          onFailure();
          return;
        }
        final value = result.valueOrNull;
        if (value == null) {
          failure = AppError.unknown(
            message: StoreMessages.operationWithoutResult,
            code: StoreCodes.unknown,
          );
          onFailure();
          return;
        }
        results[currentIndex] = value;
      }
    }

    final workerCount = items.length < concurrency ? items.length : concurrency;
    await Future.wait(
      List<Future<void>>.generate(
        workerCount,
        (_) => worker(),
        growable: false,
      ),
    );

    if (failure != null) {
      return AppResult.failure(failure!);
    }
    return AppResult.success(results.cast<T>());
  }

  Future<AppResult<_StoreLocalInventory>> _loadLocalInventory() async {
    final loadResult = await _packStore.loadPacks();
    if (loadResult.isFailure) {
      return AppResult.failure(loadResult.errorOrNull!);
    }

    final validByRemoteId = <String, StickerPack>{};
    for (final pack in loadResult.valueOrNull!) {
      if (pack.source == PackSource.remote && pack.remoteId != null) {
        validByRemoteId[pack.remoteId!] = pack;
      }
    }

    final invalidByRemoteId = <String, PackManifest>{};
    final directories = await _fileOps.listDirectories(
      (await _appDirs.packs()).path,
    );
    for (final directory in directories) {
      final manifestPath = p.join(directory.path, PackFiles.manifestFileName);
      if (!await _fileOps.fileExists(manifestPath)) {
        continue;
      }
      try {
        final json = await _jsonStore.readMap(manifestPath);
        final manifest = PackManifest.fromJson(json);
        if (manifest.source != PackSource.remote || manifest.remoteId == null) {
          continue;
        }
        if (validByRemoteId.containsKey(manifest.remoteId!)) {
          continue;
        }
        final validation = await _validator.validateManifest(
          manifest,
          folderPath: directory.path,
          mode: PackValidationMode.export,
        );
        if (validation.isFailure) {
          invalidByRemoteId[manifest.remoteId!] = manifest;
        }
      } on Object {
        continue;
      }
    }

    return AppResult.success(
      _StoreLocalInventory(
        validByRemoteId: validByRemoteId,
        invalidByRemoteId: invalidByRemoteId,
      ),
    );
  }

  ImageMimeType? _detectRemoteMime(String mimeType, Uint8List bytes) {
    final normalized = mimeType.trim().toLowerCase();
    return switch (normalized) {
      ImageMimeTypes.webp => ImageMimeType.webp,
      ImageMimeTypes.png => ImageMimeType.png,
      ImageMimeTypes.jpeg || ImageMimeTypes.jpg => ImageMimeType.jpeg,
      ImageMimeTypes.gif => ImageMimeType.gif,
      _ => MimeUtil.detect(bytes),
    };
  }
}

class _StoreRequestController {
  _StoreRequestController(this.root, this._mapper, this.packId) {
    root?.whenCancel.then((_) => cancelOutstanding());
  }

  final CancelToken? root;
  final StoreMapper _mapper;
  final String? packId;
  final List<CancelToken> _children = <CancelToken>[];

  bool get isCancelled => root?.isCancelled ?? false;

  CancelToken branch() {
    final token = CancelToken();
    if (root?.isCancelled ?? false) {
      token.cancel(root?.cancelError);
    } else {
      root?.whenCancel.then((_) {
        if (!token.isCancelled) {
          token.cancel(root?.cancelError);
        }
      });
    }
    _children.add(token);
    return token;
  }

  void cancelOutstanding() {
    for (final token in _children) {
      if (!token.isCancelled) {
        token.cancel(root?.cancelError);
      }
    }
  }

  AppError cancelledError(StoreOperationScope scope) {
    return _mapper.toAppError(
      StoreFailure(
        type: StoreFailureType.cancelled,
        scope: scope,
        message: StoreMessages.operationCancelled,
        code: StoreCodes.cancelled,
        retryable: true,
        packId: packId,
      ),
    );
  }
}

enum _StoreRemoteAssetKind { thumbnail, tray, sticker }

class _StoreRemoteAssetDescriptor {
  const _StoreRemoteAssetDescriptor({
    required this.index,
    required this.fileId,
    required this.outputFileName,
    required this.kind,
  });

  final int index;
  final String fileId;
  final String outputFileName;
  final _StoreRemoteAssetKind kind;

  _StoreRemoteAssetDescriptor copyWith({String? fileId}) {
    return _StoreRemoteAssetDescriptor(
      index: index,
      fileId: fileId ?? this.fileId,
      outputFileName: outputFileName,
      kind: kind,
    );
  }
}

class _StoreAssetPlan {
  const _StoreAssetPlan({required this.descriptor, required this.fileInfo});

  final _StoreRemoteAssetDescriptor descriptor;
  final StoreRemoteFileInfo fileInfo;

  String get outputFileName => descriptor.outputFileName;

  bool get isSticker => descriptor.kind == _StoreRemoteAssetKind.sticker;
}

class _StoreDownloadedAsset {
  const _StoreDownloadedAsset({
    required this.outputFileName,
    required this.isSticker,
  });

  final String outputFileName;
  final bool isSticker;
}

class _StoreLocalInventory {
  const _StoreLocalInventory({
    required this.validByRemoteId,
    required this.invalidByRemoteId,
  });

  final Map<String, StickerPack> validByRemoteId;
  final Map<String, PackManifest> invalidByRemoteId;
}

class _AssetBytesValidationInput {
  const _AssetBytesValidationInput({
    required this.bytes,
    required this.animatedPack,
    required this.isSticker,
  });

  final Uint8List bytes;
  final bool animatedPack;
  final bool isSticker;
}

String? _validateAssetBytesInBackground(_AssetBytesValidationInput input) {
  final validator = PackValidator();
  final result = input.isSticker
      ? validator.validateStickerBytes(
          input.bytes,
          animatedPack: input.animatedPack,
        )
      : validator.validateTrayBytes(input.bytes);
  return result.errorOrNull?.safeMessage;
}

class _StoreProgressTracker {
  _StoreProgressTracker({
    required this.packId,
    required List<_StoreAssetPlan> plans,
    required this.onProgress,
  }) : totalBytes = plans.fold<int>(
         0,
         (sum, plan) => sum + plan.fileInfo.sizeBytes,
       ),
       totalAssets = plans.length;

  final String packId;
  final void Function(StoreDownloadProgress progress)? onProgress;
  final int totalBytes;
  final int totalAssets;
  final Map<String, int> _receivedByFileId = <String, int>{};
  final Set<String> _completedFileIds = <String>{};
  var _receivedBytes = 0;
  var _completedAssets = 0;

  void update(String fileId, int received) {
    final previous = _receivedByFileId[fileId] ?? 0;
    if (received == previous) {
      return;
    }
    _receivedByFileId[fileId] = received;
    _receivedBytes += received - previous;
    _emit();
  }

  void complete(String fileId, int totalFileBytes) {
    if (!_completedFileIds.add(fileId)) {
      return;
    }
    update(fileId, totalFileBytes);
    _completedAssets += 1;
    _emit();
  }

  void _emit() {
    onProgress?.call(
      StoreDownloadProgress(
        packId: packId,
        receivedBytes: _receivedBytes,
        totalBytes: totalBytes,
        completedAssets: _completedAssets,
        totalAssets: totalAssets,
      ),
    );
  }
}
