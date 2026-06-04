import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/pack_models.dart';

part 'store_models.freezed.dart';

enum StoreCatalogStatus { initial, loading, success, empty, error }

enum StoreOperationScope { catalog, detail, download, repair, localSync }

enum StoreFailureType {
  offline,
  timeout,
  badCertificate,
  unauthorized,
  notFound,
  invalidBucket,
  invalidFileId,
  invalidCatalog,
  missingFile,
  partialDownload,
  corruptAsset,
  duplicatePack,
  outdatedLocalVersion,
  insufficientStorage,
  rateLimited,
  server,
  cancelled,
  unsupportedFormat,
  validation,
  storage,
  unknown,
}

@freezed
abstract class StoreFailure with _$StoreFailure {
  const factory StoreFailure({
    required StoreFailureType type,
    required StoreOperationScope scope,
    required String message,
    @Default(false) bool retryable,
    String? code,
    String? packId,
    String? fileId,
    @Default(<String>[]) List<String> reasons,
  }) = _StoreFailure;
}

@freezed
abstract class StoreCategory with _$StoreCategory {
  const factory StoreCategory({
    required String id,
    required String name,
    @Default(0) int order,
  }) = _StoreCategory;
}

@freezed
abstract class StoreCatalogIssue with _$StoreCatalogIssue {
  const factory StoreCatalogIssue({
    String? packId,
    int? packIndex,
    required StoreFailureType type,
    required String message,
  }) = _StoreCatalogIssue;
}

@freezed
abstract class StoreRemoteFileInfo with _$StoreRemoteFileInfo {
  const factory StoreRemoteFileInfo({
    required String fileId,
    required String name,
    required String mimeType,
    required int sizeBytes,
  }) = _StoreRemoteFileInfo;
}

@freezed
abstract class StoreRemotePack with _$StoreRemotePack {
  const StoreRemotePack._();

  const factory StoreRemotePack({
    required String id,
    required int version,
    required String name,
    required String publisher,
    String? categoryId,
    @Default(false) bool featured,
    required String trayFileId,
    @Default(<String>[]) List<String> stickerFileIds,
    String? thumbnailFileId,
    @Default(false) bool animated,
    @Default(<String>[]) List<String> tags,
    @Default(0) int sizeBytes,
  }) = _StoreRemotePack;

  int get assetCount => stickerFileIds.length + 1;
}

@freezed
abstract class StoreCatalog with _$StoreCatalog {
  const StoreCatalog._();

  const factory StoreCatalog({
    required int version,
    DateTime? updatedAt,
    @Default(<StoreCategory>[]) List<StoreCategory> categories,
    @Default(<StoreRemotePack>[]) List<StoreRemotePack> packs,
    @Default(<String, StoreRemotePack>{})
    Map<String, StoreRemotePack> packsById,
    @Default(<String>[]) List<String> featuredPackIds,
    @Default(<StoreCatalogIssue>[]) List<StoreCatalogIssue> issues,
  }) = _StoreCatalog;

  bool get isEmpty => packs.isEmpty;

  StoreRemotePack? packById(String packId) => packsById[packId];
}

@freezed
abstract class StoreLocalPackStatus with _$StoreLocalPackStatus {
  const StoreLocalPackStatus._();

  const factory StoreLocalPackStatus({
    required String remotePackId,
    String? localPackId,
    int? localVersion,
    @Default(false) bool installed,
    @Default(false) bool valid,
    @Default(false) bool sameVersionInstalled,
    @Default(false) bool updateAvailable,
    @Default(false) bool repairAvailable,
  }) = _StoreLocalPackStatus;

  bool get canDownload => !installed || updateAvailable || repairAvailable;

  bool get canUpdate => updateAvailable;

  bool get canOpen => installed && valid && !updateAvailable;

  bool get canRepair => repairAvailable;
}

@freezed
abstract class StoreDownloadProgress with _$StoreDownloadProgress {
  const StoreDownloadProgress._();

  const factory StoreDownloadProgress({
    required String packId,
    @Default(0) int receivedBytes,
    @Default(0) int totalBytes,
    @Default(0) int completedAssets,
    @Default(0) int totalAssets,
  }) = _StoreDownloadProgress;

  double get fraction {
    if (totalBytes <= 0) {
      return 0;
    }
    final value = receivedBytes / totalBytes;
    return value.clamp(0, 1).toDouble();
  }
}

@freezed
abstract class StorePackDetail with _$StorePackDetail {
  const factory StorePackDetail({
    required StoreRemotePack remote,
    required StoreLocalPackStatus localStatus,
    StickerPack? localPack,
  }) = _StorePackDetail;
}

@freezed
abstract class StoreCatalogSnapshot with _$StoreCatalogSnapshot {
  const factory StoreCatalogSnapshot({
    required StoreCatalog catalog,
    @Default(<String, StoreLocalPackStatus>{})
    Map<String, StoreLocalPackStatus> localStatuses,
    @Default(<String, StorePackDetail>{})
    Map<String, StorePackDetail> packDetails,
  }) = _StoreCatalogSnapshot;
}
