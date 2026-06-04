class AppUiStrings {
  const AppUiStrings._();

  static const String appTitle = 'StickerZ';
  static const String homeTab = 'Home';
  static const String createTab = 'Create';
  static const String storeTab = 'Store';
  static const String settingsTab = 'Settings';
}

class BaseUiStrings {
  const BaseUiStrings._();

  static const String storePlaceholder = 'Store screen will be added later.';
}

class LibraryUiStrings {
  const LibraryUiStrings._();

  static const String addPackTooltip = 'Add pack';
  static const String createPackTitle = 'New sticker pack';
  static const String createPackPrompt =
      'Name your sticker pack to start building it.';
  static const String packNameLabel = 'Pack name';
  static const String continueAction = 'Continue';
  static const String emptyLibraryTitle = 'No sticker packs yet';
  static const String emptyLibraryMessage =
      'Create a sticker pack to start your library.';
  static const String createFirstPackAction = 'Create sticker pack';
  static const String traySection = 'Tray icon';
  static const String stickersSection = 'Stickers';
  static const String trayMissing = 'No tray icon yet';
  static const String stickersEmpty = 'No stickers added yet';
  static const String addTrayAction = 'Add tray icon';
  static const String editTrayAction = 'Edit tray icon';
  static const String replaceTrayAction = 'Replace tray icon';
  static const String addStickerAction = 'Add sticker';
  static const String editPackAction = 'Edit details';
  static const String deletePackAction = 'Delete pack';
  static const String editStickerAction = 'Edit';
  static const String replaceStickerAction = 'Replace';
  static const String deleteStickerAction = 'Delete';
  static const String editPackTitle = 'Edit pack';
  static const String saveAction = 'Save';
  static const String cancelAction = 'Cancel';
  static const String deletePackTitle = 'Delete pack?';
  static const String deleteStickerTitle = 'Delete sticker?';

  static String packSummary(int stickerCount, int version) {
    return '$stickerCount stickers • v$version';
  }

  static String deletePackMessage(String packName) {
    return 'Delete $packName from your library?';
  }

  static String deleteStickerMessage(String fileName) {
    return 'Delete $fileName from this pack?';
  }
}

class AppErrorStrings {
  const AppErrorStrings._();

  static const String operationCancelled = 'Operation cancelled.';
  static const String whatsappMissing = 'WhatsApp is not installed.';
  static const String whatsappBusinessMissing =
      'WhatsApp Business is not installed.';
  static const String noCompatibleTarget =
      'No compatible WhatsApp target is available.';
  static const String providerUnavailable =
      'The sticker provider is unavailable.';
  static const String exportCancelled = 'Sticker export was cancelled.';
  static const String exportRejected = 'WhatsApp rejected the sticker pack.';
}

class AppwriteEnvironmentStrings {
  const AppwriteEnvironmentStrings._();

  static const String projectId = '6a1c58690013a8dad797';
  static const String projectName = 'Stickerz';
  static const String publicEndpoint = 'https://sgp.cloud.appwrite.io/v1';
  static const String bucketId = '6a1c5a9a0039f4575416';
  static const String catalogFileId = 'catalog_v1_index';
}

class AppwriteConstants {
  const AppwriteConstants._();

  static const String invalidEndpointUri =
      'Appwrite endpoint is not a valid URI.';
  static const String endpointMustBeAbsolute =
      'Appwrite endpoint must be an absolute URI.';
  static const String responseFormatVersion = '1.8.0';
  static const String headerProject = 'X-Appwrite-Project';
  static const String headerResponseFormat = 'X-Appwrite-Response-Format';
  static const String queryProject = 'project';
  static const String pathStorage = 'storage';
  static const String pathBuckets = 'buckets';
  static const String pathFiles = 'files';
  static const String pathDownload = 'download';
  static const String pathView = 'view';
  static const String fieldProjectId = 'projectId';
  static const String fieldProjectName = 'projectName';
  static const String fieldBucketId = 'bucketId';
  static const String fieldCatalogFileId = 'catalogFileId';
  static const String fieldFileId = 'fileId';

  static String missingValue(String name) {
    return 'Appwrite $name must not be empty.';
  }
}

class StoreCodes {
  const StoreCodes._();

  static const String invalidCatalog = 'store_invalid_catalog';
  static const String invalidFileInfo = 'store_invalid_file_info';
  static const String cancelled = 'store_cancelled';
  static const String timeout = 'store_timeout';
  static const String badCertificate = 'store_bad_certificate';
  static const String offline = 'store_offline';
  static const String unknown = 'store_unknown';
  static const String unauthorized = 'store_unauthorized';
  static const String invalidBucket = 'store_invalid_bucket';
  static const String invalidFileId = 'store_invalid_file_id';
  static const String rateLimited = 'store_rate_limited';
  static const String serverError = 'store_server_error';
  static const String missingFile = 'store_missing_file';
  static const String missingThumbnail = 'store_missing_thumbnail';
  static const String missingSticker = 'store_missing_sticker';
  static const String missingTray = 'store_missing_tray';
  static const String partialDownload = 'store_partial_download';
  static const String duplicatePack = 'store_duplicate_pack';
  static const String outdatedLocalVersion = 'store_outdated_local_version';
  static const String insufficientStorage = 'store_insufficient_storage';
  static const String corruptAsset = 'store_corrupt_asset';
  static const String unsupportedFormat = 'store_unsupported_format';
  static const String validation = 'store_validation';
  static const String storage = 'store_storage';
  static const String catalogFailed = 'store_catalog_failed';
  static const String packNotFound = 'store_pack_not_found';
  static const String catalogNotLoaded = 'store_catalog_not_loaded';
  static const String installResolutionFailed =
      'store_install_resolution_failed';
  static const String appwriteStorageFileNotFound = 'storage_file_not_found';
  static const String appwriteDocumentNotFound = 'document_not_found';
}

class StoreMessages {
  const StoreMessages._();

  static const String catalogInvalid = 'Store catalog is invalid.';
  static const String catalogParseFailed = 'Store catalog could not be parsed.';
  static const String catalogEmpty = 'Store catalog is empty.';
  static const String catalogLoadFailed = 'Store catalog could not be loaded.';
  static const String remoteFileMetadataInvalid =
      'Remote file metadata is invalid.';
  static const String remoteFileMetadataLoadFailed =
      'Remote file metadata could not be loaded.';
  static const String requestTimedOut = 'The store request timed out.';
  static const String operationCancelled = 'Operation cancelled.';
  static const String badCertificate =
      'The secure connection to Appwrite could not be trusted.';
  static const String offline = 'No internet connection is available.';
  static const String requestFailed = 'Store request failed.';
  static const String requestedFileNotFound =
      'The requested store file was not found.';
  static const String assetsNotPublic =
      'Store assets are not publicly accessible.';
  static const String requestsRateLimited =
      'Store requests are being rate limited.';
  static const String invalidBucket = 'Store bucket configuration is invalid.';
  static const String invalidFileId = 'Store file id is invalid.';
  static const String serverRequestFailed = 'Appwrite server request failed.';
  static const String requiredAssetMissing =
      'A required store asset is missing.';
  static const String partialDownload = 'Downloaded file is incomplete.';
  static const String duplicatePack = 'Pack id already exists locally.';
  static const String outdatedLocalVersion =
      'A newer local version is already installed.';
  static const String insufficientStorage =
      'Insufficient device storage is available.';
  static const String corruptAsset =
      'Downloaded asset is corrupted or unsupported.';
  static const String unsupportedFormat =
      'Downloaded asset format is not supported.';
  static const String validationFailed = 'Store validation failed.';
  static const String localPersistenceFailed =
      'Local store persistence failed.';
  static const String catalogRootMustBeObject =
      'Catalog root must be a JSON object.';
  static const String catalogVersionInvalid = 'Catalog version is invalid.';
  static const String catalogVersionUnsupported =
      'Catalog version is not supported by this app build.';
  static const String packEntryMustBeObject =
      'Pack entry must be a JSON object.';
  static const String packIdMustBeUnique = 'Pack id must be unique.';
  static const String stickersCountInvalid =
      'Pack must define between 3 and 30 stickers.';
  static const String stickerFileIdInvalid = 'Sticker file id is invalid.';
  static const String stickerFileIdsUnique = 'Sticker file ids must be unique.';
  static const String missingThumbnail = 'Thumbnail file is missing.';
  static const String missingTray = 'Tray file is missing.';
  static const String missingSticker = 'Sticker file is missing.';
  static const String catalogNotLoaded =
      'Store catalog has not been loaded yet.';
  static const String packNotFound = 'Store pack was not found.';
  static const String downloadedPackUnresolved =
      'Downloaded pack could not be resolved locally.';
  static const String downloadWriteFailed = 'Remote file download failed.';
  static const String downloadDiskWriteFailed =
      'Remote file could not be written to disk.';
  static const String downloadedPackStorageFailed =
      'Downloaded pack could not be stored locally.';
  static const String operationWithoutResult =
      'Store operation completed without a result.';
  static const String gifNotSupported =
      'GIF assets are not supported for local sticker packs.';
  static const String animatedPackRequiresWebp =
      'Animated packs must provide WebP assets.';

  static String missingAppwriteId(String fileId) => 'Missing \$id for $fileId';

  static String missingSizeOriginal(String fileId) {
    return 'Missing ${StoreJsonKeys.sizeOriginal} for $fileId';
  }

  static String missingField(String key) => 'Missing $key.';

  static String invalidField(String key) => '$key is invalid.';

  static String expectedBytes(int expected, int actual) {
    return 'Expected $expected bytes but received $actual bytes.';
  }
}

class StoreJsonKeys {
  const StoreJsonKeys._();

  static const String appwriteId = r'$id';
  static const String name = 'name';
  static const String mimeType = 'mimeType';
  static const String sizeOriginal = 'sizeOriginal';
  static const String type = 'type';
  static const String code = 'code';
  static const String message = 'message';
  static const String categories = 'categories';
  static const String id = 'id';
  static const String order = 'order';
  static const String index = 'index';
  static const String title = 'title';
  static const String packs = 'packs';
  static const String version = 'version';
  static const String publisher = 'publisher';
  static const String categoryId = 'categoryId';
  static const String featured = 'featured';
  static const String trayFileId = 'trayFileId';
  static const String stickerFileIds = 'stickerFileIds';
  static const String thumbnailFileId = 'thumbnailFileId';
  static const String animated = 'animated';
  static const String tags = 'tags';
  static const String sizeBytes = 'sizeBytes';
  static const String issues = 'issues';
  static const String packId = 'packId';
  static const String packIndex = 'packIndex';
  static const String updatedAt = 'updatedAt';
  static const String minimumCompatibleCatalogVersion =
      'minimumCompatibleCatalogVersion';
  static const String minCatalogVersion = 'minCatalogVersion';
  static const String packIdAlias = 'packId';
  static const String remoteId = 'remoteId';
  static const String author = 'author';
  static const String tray = 'tray';
  static const String trayFileIdSnake = 'tray_file_id';
  static const String stickers = 'stickers';
  static const String stickerFileIdsSnake = 'sticker_file_ids';
  static const String category = 'category';
  static const String categoryIdSnake = 'category_id';
  static const String thumbnail = 'thumbnail';
  static const String thumbnailFileIdSnake = 'thumbnail_file_id';
  static const String size = 'size';
  static const String fileId = 'fileId';
}

class StoreSearchTerms {
  const StoreSearchTerms._();

  static const String bucket = 'bucket';
  static const String file = 'file';
  static const String invalid = 'invalid';
  static const String fileId = 'file id';
  static const String invalidFile = 'invalid file';
}

class StoreControlReasons {
  const StoreControlReasons._();

  static const String replaced = 'replaced';
  static const String cancelled = 'cancelled';
  static const String disposed = 'disposed';
}

class PackFiles {
  const PackFiles._();

  static const String webpExtension = '.webp';
  static const String archiveExtension = '.wspack';
  static const String archiveMimeType = 'application/zip';
  static const String manifestFileName = 'manifest.json';
  static const String trayFileName = 'tray.webp';
  static const String tempDirectoryName = 'temp';
  static const String exportDirectoryName = 'export';
  static const String extractedPackDirectoryName = 'pack';
  static const String sourceArchiveFileName = 'source.wspack';
  static const String stickersDirectoryName = 'stickers';
  static const String defaultPackPrefix = 'pack';
  static const String customSource = 'custom';
  static const String remoteSource = 'remote';
  static const String fileIndent = '  ';
  static const String newline = '\n';
  static const String rawSuffix = '.raw';
  static const String tempSuffix = '.tmp';
  static const String backupSuffix = '.bak';
  static const String remoteTempMarker = '.tmp';
  static const String editableSourceSuffix = '.source';
  static const String editableStateSuffix = '.edit.json';
  static const String operationExportText = 'Import this sticker pack';

  static String stickerFileName(int index) {
    return 'sticker_${index.toString().padLeft(3, '0')}$webpExtension';
  }

  static String archiveStickerPath(int index) {
    return '$stickersDirectoryName/${index.toString().padLeft(3, '0')}$webpExtension';
  }

  static String tempFilePath(String path) => '$path$tempSuffix';

  static String rawFilePath(String path) => '$path$rawSuffix';

  static String backupPath(String path, String operationId) {
    return '$path.$operationId$backupSuffix';
  }

  static String editableSourcePrefix(String fileName) {
    return '${_sidecarBaseName(fileName)}$editableSourceSuffix';
  }

  static String editableSourceFileName(String fileName, String extension) {
    final normalizedExtension = extension.isEmpty
        ? '.png'
        : extension.startsWith('.')
        ? extension
        : '.$extension';
    return '${editableSourcePrefix(fileName)}$normalizedExtension';
  }

  static String editStateFileName(String fileName) {
    return '${_sidecarBaseName(fileName)}$editableStateSuffix';
  }

  static String _sidecarBaseName(String fileName) {
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot <= 0) {
      return fileName;
    }
    return fileName.substring(0, lastDot);
  }
}

class ImageMimeTypes {
  const ImageMimeTypes._();

  static const String webp = 'image/webp';
  static const String png = 'image/png';
  static const String jpeg = 'image/jpeg';
  static const String jpg = 'image/jpg';
  static const String gif = 'image/gif';
}

class PackPatterns {
  const PackPatterns._();

  static const String packId = r'^[a-z0-9][a-z0-9._-]{0,127}$';
  static const String fileName = r'^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$';
  static const String archiveStickerPath =
      r'^stickers/[A-Za-z0-9][A-Za-z0-9._-]{0,127}\.webp$';
  static const String stickerFileNameCapture = r'sticker_(\d{3})\.webp';
  static const String invalidLibraryIdCharacters = r'[^a-z0-9._-]+';
  static const String repeatedUnderscores = r'_+';
  static const String edgeSeparators = r'^[_\-.]+|[_\-.]+$';
}

class PackJsonKeys {
  const PackJsonKeys._();

  static const String ok = 'ok';
  static const String code = 'code';
  static const String message = 'message';
  static const String debugDetails = 'debugDetails';
  static const String version = 'version';
  static const String id = 'id';
  static const String name = 'name';
  static const String publisher = 'publisher';
  static const String tray = 'tray';
  static const String stickers = 'stickers';
  static const String file = 'file';
  static const String emojis = 'emojis';
  static const String accessibilityText = 'accessibilityText';
  static const String animated = 'animated';
  static const String source = 'source';
  static const String remoteId = 'remoteId';
}

class PackCodes {
  const PackCodes._();

  static const String invalidPack = 'invalidPack';
  static const String unsafeArchivePath = 'unsafeArchivePath';
  static const String malformedManifest = 'malformedManifest';
  static const String invalidTray = 'invalidTray';
  static const String invalidSticker = 'invalidSticker';
  static const String missingManifest = 'missingManifest';
  static const String unsupportedVersion = 'unsupportedVersion';
  static const String missingTray = 'missingTray';
  static const String missingSticker = 'missingSticker';
  static const String corruptedArchive = 'corruptedArchive';
  static const String storageFailed = 'storageFailed';
  static const String unknown = 'unknown';
}

class PackMessages {
  const PackMessages._();

  static const String packIdInvalid = 'Pack id is invalid.';
  static const String packNameInvalid = 'Pack name is invalid.';
  static const String publisherInvalid = 'Publisher is invalid.';
  static const String versionPositive = 'Version must be greater than zero.';
  static const String remoteIdInvalid = 'Remote id is invalid.';
  static const String customCannotDefineRemoteId =
      'Custom packs cannot define a remote id.';
  static const String onlyRemoteCanBeAnimated =
      'Only remote packs can be animated.';
  static const String maxStickerCountExceeded =
      'Pack exceeds the maximum sticker count.';
  static const String stickerCountRange =
      'Pack must contain between 3 and 30 stickers.';
  static const String trayFileNameInvalid = 'Tray filename is invalid.';
  static const String trayRequired = 'Tray icon is required.';
  static const String stickerNamesUnique = 'Sticker filenames must be unique.';
  static const String trayMissing = 'Tray icon is missing.';
  static const String animatedPackContainsStatic =
      'Animated packs cannot contain static stickers.';
  static const String staticPackContainsAnimated =
      'Static packs cannot contain animated stickers.';
  static const String stickerMustBeWebp = 'Sticker must be a WebP image.';
  static const String malformedStickerWebp = 'Sticker WebP data is malformed.';
  static const String stickerDimensions = 'Sticker dimensions must be 512x512.';
  static const String animatedPackRequiresAnimatedWebp =
      'Animated packs require animated WebP stickers.';
  static const String animatedStickerTooLarge =
      'Animated sticker exceeds the WhatsApp size limit.';
  static const String animatedStickerTimingInvalid =
      'Animated sticker timing is invalid.';
  static const String staticPackCannotContainAnimatedWebp =
      'Static packs cannot contain animated WebP stickers.';
  static const String stickerTooLarge =
      'Sticker exceeds the WhatsApp size limit.';
  static const String trayMustBeWebp = 'Tray icon must be a WebP image.';
  static const String malformedTrayWebp = 'Tray icon WebP data is malformed.';
  static const String trayMustBeStatic = 'Tray icon must be static.';
  static const String trayDimensions = 'Tray icon dimensions must be 96x96.';
  static const String trayTooLarge =
      'Tray icon exceeds the WhatsApp size limit.';
  static const String failedReadLocalPacks =
      'Failed to read local sticker packs.';
  static const String packIdAlreadyExists = 'Pack id already exists.';
  static const String failedCreatePack = 'Failed to create the pack.';
  static const String packNotFound = 'Pack was not found.';
  static const String maxLocalStickersReached = 'Pack already has 30 stickers.';
  static const String failedAddSticker =
      'Failed to add the sticker to the pack.';
  static const String failedUpdateTray = 'Failed to update the tray icon.';
  static const String stickerNotFound = 'Sticker was not found.';
  static const String failedReplaceSticker = 'Failed to replace the sticker.';
  static const String failedDeletePack = 'Failed to delete the pack.';
  static const String downloadedPackMustBeRemote =
      'Downloaded pack must be marked as remote.';
  static const String downloadedPackIdMismatch =
      'Downloaded pack id does not match the listing.';
  static const String downloadedPackVersionMismatch =
      'Downloaded pack version does not match the listing.';
  static const String newerRemoteAlreadyInstalled =
      'An equal or newer remote version is already installed.';
  static const String packIdExistsLocally = 'Pack id already exists locally.';
  static const String downloadedManifestInvalid =
      'Downloaded pack manifest is invalid.';
  static const String failedInstallDownloadedPack =
      'Failed to install the downloaded pack.';
  static const String importedPackMustBeLocal =
      'Imported pack must be a local pack.';
  static const String importedManifestInvalid =
      'Imported pack manifest is invalid.';
  static const String failedImportPack = 'Failed to import the sticker pack.';
  static const String failedSaveManifest = 'Failed to save the pack manifest.';
  static const String failedExportPack = 'Failed to export the sticker pack.';
  static const String shareFailed = 'Sticker pack could not be shared.';
  static const String archiveCorrupted = 'Pack archive is corrupted.';
  static const String archiveTooManyFiles = 'Pack contains too many files.';
  static const String archiveUnsafePaths =
      'Pack archive contains unsafe paths.';
  static const String archiveFilesTooLarge = 'Pack files are too large.';
  static const String manifestInvalid = 'Pack manifest is invalid.';
  static const String trayInvalid = 'Tray icon is invalid.';
  static const String stickerInvalid = 'Sticker file is invalid.';
  static const String archiveUnsupportedFiles =
      'Pack archive contains unsupported files.';
  static const String manifestMissing = 'Pack manifest is missing.';
  static const String versionUnsupported = 'Pack version is not supported.';
  static const String trayMissingFromPack = 'Pack tray icon is missing.';
  static const String stickerMissingFromPack = 'A sticker file is missing.';
  static const String packCouldNotBeImported = 'Pack could not be imported.';
  static const String expectedJsonObject = 'Expected a JSON object.';
  static const String queryTargetsFailed = 'Failed to query WhatsApp targets.';
  static const String launchExportFailed =
      'Failed to launch WhatsApp sticker export.';

  static String stickerFileNameInvalid(String fileName) {
    return 'Sticker filename is invalid: $fileName.';
  }

  static String accessibilityTooLong(String fileName) {
    return 'Accessibility text is too long for $fileName.';
  }

  static String stickerMissing(String fileName) {
    return 'Sticker is missing: $fileName.';
  }

  static String stickerValidation(String fileName, String message) {
    return '$fileName: $message';
  }
}

class WhatsAppChannelKeys {
  const WhatsAppChannelKeys._();

  static const String channelName = 'stickerz/core';
  static const String getPacksDirectory = 'getPacksDirectory';
  static const String getTargets = 'getTargets';
  static const String canAddPack = 'canAddPack';
  static const String addPack = 'addPack';
  static const String encodeWebp = 'encodeWebp';
  static const String takeIncomingPack = 'takeIncomingPack';
  static const String copyImportUri = 'copyImportUri';
  static const String packId = 'packId';
  static const String packName = 'packName';
  static const String installed = 'installed';
  static const String whitelisted = 'whitelisted';
  static const String status = 'status';
  static const String validationError = 'validationError';
  static const String bytes = 'bytes';
  static const String quality = 'quality';
  static const String lossless = 'lossless';
  static const String uri = 'uri';
  static const String completed = 'completed';
  static const String alreadyAdded = 'alreadyAdded';
  static const String cancelled = 'cancelled';
  static const String rejected = 'rejected';
  static const String missing = 'missing';
  static const String consumer = 'consumer';
  static const String business = 'business';
}

class WhatsAppMessages {
  const WhatsAppMessages._();

  static const String packsDirectoryUnavailable =
      'Sticker pack directory unavailable.';
  static const String webpEncodingFailed = 'WebP encoding failed.';
  static const String validatePackDebugLabel = 'validateWhatsAppPack';
  static const String packNameLength = 'Pack name must be 1-128 characters.';
  static const String publisherLength = 'Publisher must be 1-128 characters.';
  static const String versionPositive =
      'Pack version must be greater than zero.';
  static const String safeTrayFileName =
      'Tray filename must be a safe .webp name.';
  static const String trayIconLabel = 'Tray icon';
  static const String stickerCountRange = 'Pack must contain 3-30 stickers.';
  static const String packIdRules =
      'Pack id must use a-z, 0-9, dot, underscore, or hyphen and be under 128 characters.';

  static String invalidStickerFileName(String fileName) {
    return 'Sticker filename is invalid: $fileName.';
  }

  static String accessibilityMaxLength(int maxLength) {
    return 'Accessibility text must be at most $maxLength characters.';
  }

  static String exceedsSizeLimit(String label) {
    return '$label exceeds WhatsApp size limits.';
  }

  static String mustBeValidWebp(String label) {
    return '$label must be valid WebP.';
  }

  static String mustBeDimensions(String label, int width, int height) {
    return '$label must be ${width}x$height.';
  }

  static String mustBeAnimatedWebp(String label) {
    return '$label must be animated WebP.';
  }

  static String mustBeStaticWebp(String label) {
    return '$label must be static WebP.';
  }

  static String invalidAnimationTiming(String label) {
    return '$label has invalid animation timing.';
  }
}

class WebpChunkTypes {
  const WebpChunkTypes._();

  static const String vp8x = 'VP8X';
  static const String vp8 = 'VP8 ';
  static const String vp8l = 'VP8L';
  static const String anim = 'ANIM';
  static const String anmf = 'ANMF';
}

class UriSchemes {
  const UriSchemes._();

  static const String content = 'content';
  static const String file = 'file';
}

class EditorMessages {
  const EditorMessages._();

  static const String noSourceImage = 'No source image is available.';
  static const String imageSelectionFailed = 'Image selection failed.';
  static const String outputMustBeJpegOrPng =
      'Editor output must be a JPEG or PNG image.';
  static const String unsupportedImageFormat = 'Unsupported image format.';
  static const String imageResizingFailed = 'Image resizing failed.';
  static const String stickerProcessingFailed = 'Sticker processing failed.';
  static const String imageSerializationFailed =
      'Failed to serialize image data.';
  static const String webpEncodingFailed = 'WebP encoding failed.';
  static const String processRequestSourceAssert =
      'sourcePath != null || sourceBytes != null';

  static String unableToCompressImage(int maxBytes) {
    return 'Unable to compress image within $maxBytes bytes.';
  }
}
