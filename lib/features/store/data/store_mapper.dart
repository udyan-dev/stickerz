import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/util/constants/constants.dart';
import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../features/library/util/library_ids.dart';
import '../domain/store_models.dart';

class StoreMapper {
  StoreMapper({this.supportedCatalogVersion = 1});

  final int supportedCatalogVersion;

  Future<AppResult<StoreCatalog>> mapCatalogBytes(Uint8List bytes) async {
    try {
      final payload = await Isolate.run<Map<String, Object?>>(
        () => _normalizeCatalogPayload((bytes, supportedCatalogVersion)),
      );
      return AppResult.success(_catalogFromPayload(payload));
    } on FormatException catch (error) {
      return AppResult.failure(
        toAppError(
          StoreFailure(
            type: StoreFailureType.invalidCatalog,
            scope: StoreOperationScope.catalog,
            message: StoreMessages.catalogInvalid,
            code: StoreCodes.invalidCatalog,
            retryable: true,
            reasons: <String>[error.message],
          ),
        ),
      );
    } on Object catch (error) {
      return AppResult.failure(
        AppError.parse(
          message: StoreMessages.catalogParseFailed,
          code: StoreCodes.invalidCatalog,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  AppResult<StoreRemoteFileInfo> mapRemoteFileInfo(
    Map<String, dynamic> payload, {
    required String fileId,
  }) {
    final normalizedId = payload[StoreJsonKeys.appwriteId]?.toString().trim();
    final name = payload[StoreJsonKeys.name]?.toString().trim() ?? '';
    final mimeType = payload[StoreJsonKeys.mimeType]?.toString().trim() ?? '';
    final sizeBytes =
        (payload[StoreJsonKeys.sizeOriginal] as num?)?.toInt() ?? 0;
    if (normalizedId == null || normalizedId.isEmpty) {
      return AppResult.failure(
        AppError.parse(
          message: StoreMessages.remoteFileMetadataInvalid,
          code: StoreCodes.invalidFileInfo,
          debugDetails: StoreMessages.missingAppwriteId(fileId),
        ),
      );
    }
    if (sizeBytes <= 0) {
      return AppResult.failure(
        AppError.parse(
          message: StoreMessages.remoteFileMetadataInvalid,
          code: StoreCodes.invalidFileInfo,
          debugDetails: StoreMessages.missingSizeOriginal(fileId),
        ),
      );
    }
    return AppResult.success(
      StoreRemoteFileInfo(
        fileId: normalizedId,
        name: name,
        mimeType: mimeType,
        sizeBytes: sizeBytes,
      ),
    );
  }

  StoreFailure failureFromDioException(
    DioException error, {
    required StoreOperationScope scope,
    String? packId,
    String? fileId,
  }) {
    final response = error.response;
    final code = _responseCode(response?.data);
    final message = _responseMessage(response?.data) ?? error.message;
    final statusCode = response?.statusCode;

    return switch (error.type) {
      DioExceptionType.cancel => _failure(
        StoreFailureType.cancelled,
        scope: scope,
        message: StoreMessages.operationCancelled,
        code: StoreCodes.cancelled,
        retryable: true,
        packId: packId,
        fileId: fileId,
      ),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => _failure(
        StoreFailureType.timeout,
        scope: scope,
        message: StoreMessages.requestTimedOut,
        code: StoreCodes.timeout,
        retryable: true,
        packId: packId,
        fileId: fileId,
      ),
      DioExceptionType.badCertificate => _failure(
        StoreFailureType.badCertificate,
        scope: scope,
        message: StoreMessages.badCertificate,
        code: StoreCodes.badCertificate,
        retryable: false,
        packId: packId,
        fileId: fileId,
      ),
      DioExceptionType.connectionError => _failureFromTransportError(
        error.error,
        scope: scope,
        packId: packId,
        fileId: fileId,
      ),
      DioExceptionType.badResponse => _failureFromBadResponse(
        statusCode: statusCode,
        code: code,
        message: message,
        scope: scope,
        packId: packId,
        fileId: fileId,
      ),
      DioExceptionType.unknown ||
      DioExceptionType.transformTimeout => _failureFromTransportError(
        error.error,
        scope: scope,
        packId: packId,
        fileId: fileId,
        fallbackMessage: message,
      ),
    };
  }

  StoreFailure failureFromAppError(
    AppError error, {
    required StoreOperationScope scope,
    String? packId,
  }) {
    final code = error.code ?? '';
    final mapped = _failureFromCode(code, scope: scope, packId: packId);
    if (mapped != null) {
      return mapped.copyWith(
        message: error.safeMessage,
        reasons: error.reasons,
      );
    }
    if (error.type == AppErrorType.cancelled) {
      return _failure(
        StoreFailureType.cancelled,
        scope: scope,
        message: error.safeMessage,
        code: code.isEmpty ? StoreCodes.cancelled : code,
        retryable: true,
        packId: packId,
      );
    }
    if (error.type == AppErrorType.parse) {
      return _failure(
        StoreFailureType.invalidCatalog,
        scope: scope,
        message: error.safeMessage,
        code: code.isEmpty ? StoreCodes.invalidCatalog : code,
        retryable: scope == StoreOperationScope.catalog,
        packId: packId,
        reasons: error.reasons,
      );
    }
    if (error.type == AppErrorType.validation ||
        error.type == AppErrorType.invalidPack) {
      return _failure(
        StoreFailureType.validation,
        scope: scope,
        message: error.safeMessage,
        code: code.isEmpty ? StoreCodes.validation : code,
        retryable: scope != StoreOperationScope.download,
        packId: packId,
        reasons: error.reasons,
      );
    }
    if (error.type == AppErrorType.storage) {
      return _failure(
        StoreFailureType.storage,
        scope: scope,
        message: error.safeMessage,
        code: code.isEmpty ? StoreCodes.storage : code,
        retryable: true,
        packId: packId,
        reasons: error.reasons,
      );
    }
    return _failure(
      StoreFailureType.unknown,
      scope: scope,
      message: error.safeMessage,
      code: code.isEmpty ? StoreCodes.unknown : code,
      retryable: true,
      packId: packId,
      reasons: error.reasons,
    );
  }

  AppError toAppError(StoreFailure failure) {
    return switch (failure.type) {
      StoreFailureType.cancelled => AppError.cancelled(
        code: failure.code,
        debugDetails: failure.code,
      ),
      StoreFailureType.invalidCatalog => AppError.parse(
        message: failure.message,
        code: failure.code,
        debugDetails: failure.reasons.join('; '),
      ),
      StoreFailureType.missingFile ||
      StoreFailureType.partialDownload ||
      StoreFailureType.insufficientStorage ||
      StoreFailureType.storage => AppError.storage(
        message: failure.message,
        code: failure.code,
        debugDetails: failure.reasons.join('; '),
      ),
      StoreFailureType.invalidFileId ||
      StoreFailureType.duplicatePack ||
      StoreFailureType.outdatedLocalVersion ||
      StoreFailureType.unsupportedFormat ||
      StoreFailureType.validation => AppError.validation(
        message: failure.message,
        reasons: failure.reasons,
        code: failure.code,
      ),
      StoreFailureType.corruptAsset => AppError.invalidPack(
        message: failure.message,
        reasons: failure.reasons,
        code: failure.code,
      ),
      _ => AppError.platform(
        message: failure.message,
        code: failure.code,
        debugDetails: failure.reasons.join('; '),
      ),
    };
  }

  StoreCatalog _catalogFromPayload(Map<String, Object?> payload) {
    final categories =
        ((payload[StoreJsonKeys.categories] as List?) ?? const <Object?>[])
            .whereType<Map>()
            .map(
              (value) => StoreCategory(
                id: value[StoreJsonKeys.id]!.toString(),
                name: value[StoreJsonKeys.name]!.toString(),
                order: value[StoreJsonKeys.order] as int? ?? 0,
              ),
            )
            .toList(growable: false)
          ..sort((left, right) {
            final byOrder = left.order.compareTo(right.order);
            if (byOrder != 0) {
              return byOrder;
            }
            return left.name.toLowerCase().compareTo(right.name.toLowerCase());
          });

    final packs = ((payload[StoreJsonKeys.packs] as List?) ?? const <Object?>[])
        .whereType<Map>()
        .map(
          (value) => StoreRemotePack(
            id: value[StoreJsonKeys.id]!.toString(),
            version: value[StoreJsonKeys.version] as int,
            name: value[StoreJsonKeys.name]!.toString(),
            publisher: value[StoreJsonKeys.publisher]!.toString(),
            categoryId: value[StoreJsonKeys.categoryId]?.toString(),
            featured: value[StoreJsonKeys.featured] as bool? ?? false,
            trayFileId: value[StoreJsonKeys.trayFileId]!.toString(),
            stickerFileIds:
                (value[StoreJsonKeys.stickerFileIds] as List? ??
                        const <Object?>[])
                    .map((item) => item.toString())
                    .toList(growable: false),
            thumbnailFileId: value[StoreJsonKeys.thumbnailFileId]?.toString(),
            animated: value[StoreJsonKeys.animated] as bool? ?? false,
            tags: (value[StoreJsonKeys.tags] as List? ?? const <Object?>[])
                .map((item) => item.toString())
                .toList(growable: false),
            sizeBytes: value[StoreJsonKeys.sizeBytes] as int? ?? 0,
          ),
        )
        .toList(growable: false);

    final packsById = <String, StoreRemotePack>{
      for (final pack in packs) pack.id: pack,
    };

    final issues =
        ((payload[StoreJsonKeys.issues] as List?) ?? const <Object?>[])
            .whereType<Map>()
            .map(
              (value) => StoreCatalogIssue(
                packId: value[StoreJsonKeys.packId]?.toString(),
                packIndex: value[StoreJsonKeys.packIndex] as int?,
                type: StoreFailureType.values.byName(
                  value[StoreJsonKeys.type]!.toString(),
                ),
                message: value[StoreJsonKeys.message]!.toString(),
              ),
            )
            .toList(growable: false);

    final updatedAtRaw = payload[StoreJsonKeys.updatedAt]?.toString();
    return StoreCatalog(
      version: payload[StoreJsonKeys.version] as int,
      updatedAt: updatedAtRaw == null || updatedAtRaw.isEmpty
          ? null
          : DateTime.tryParse(updatedAtRaw),
      categories: categories,
      packs: packs,
      packsById: packsById,
      featuredPackIds: packs
          .where((pack) => pack.featured)
          .map((pack) => pack.id)
          .toList(growable: false),
      issues: issues,
    );
  }

  String? _responseCode(Object? data) {
    final map = _responseMap(data);
    return map[StoreJsonKeys.type]?.toString() ??
        map[StoreJsonKeys.code]?.toString();
  }

  String? _responseMessage(Object? data) {
    final map = _responseMap(data);
    return map[StoreJsonKeys.message]?.toString();
  }

  Map<String, dynamic> _responseMap(Object? data) {
    try {
      if (data is Map<String, dynamic>) {
        return data;
      }
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
      if (data is String && data.isNotEmpty) {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      }
      if (data is List<int> && data.isNotEmpty) {
        final decoded = jsonDecode(utf8.decode(data));
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      }
    } on Object {
      return const <String, dynamic>{};
    }
    return const <String, dynamic>{};
  }

  StoreFailure _failureFromTransportError(
    Object? error, {
    required StoreOperationScope scope,
    String? packId,
    String? fileId,
    String? fallbackMessage,
  }) {
    if (error is SocketException) {
      return _failure(
        StoreFailureType.offline,
        scope: scope,
        message: StoreMessages.offline,
        code: StoreCodes.offline,
        retryable: true,
        packId: packId,
        fileId: fileId,
      );
    }
    if (error is HandshakeException) {
      return _failure(
        StoreFailureType.badCertificate,
        scope: scope,
        message: StoreMessages.badCertificate,
        code: StoreCodes.badCertificate,
        retryable: false,
        packId: packId,
        fileId: fileId,
      );
    }
    return _failure(
      StoreFailureType.unknown,
      scope: scope,
      message: fallbackMessage ?? StoreMessages.requestFailed,
      code: StoreCodes.unknown,
      retryable: true,
      packId: packId,
      fileId: fileId,
    );
  }

  StoreFailure _failureFromBadResponse({
    required int? statusCode,
    required String? code,
    required String? message,
    required StoreOperationScope scope,
    String? packId,
    String? fileId,
  }) {
    final normalizedCode = code?.trim();
    final normalizedMessage = message?.trim();
    final lowerCode = normalizedCode?.toLowerCase() ?? '';
    final lowerMessage = normalizedMessage?.toLowerCase() ?? '';

    if (normalizedCode == StoreCodes.appwriteStorageFileNotFound ||
        normalizedCode == StoreCodes.appwriteDocumentNotFound ||
        statusCode == 404) {
      return _failure(
        StoreFailureType.notFound,
        scope: scope,
        message: StoreMessages.requestedFileNotFound,
        code: normalizedCode ?? StoreCodes.appwriteStorageFileNotFound,
        retryable: true,
        packId: packId,
        fileId: fileId,
      );
    }
    if (statusCode == 401 || statusCode == 403) {
      return _failure(
        StoreFailureType.unauthorized,
        scope: scope,
        message: StoreMessages.assetsNotPublic,
        code: normalizedCode ?? StoreCodes.unauthorized,
        retryable: true,
        packId: packId,
        fileId: fileId,
      );
    }
    if (statusCode == 429) {
      return _failure(
        StoreFailureType.rateLimited,
        scope: scope,
        message: StoreMessages.requestsRateLimited,
        code: normalizedCode ?? StoreCodes.rateLimited,
        retryable: true,
        packId: packId,
        fileId: fileId,
      );
    }
    if ((statusCode == 400 || statusCode == 404) &&
        (lowerCode.contains(StoreSearchTerms.bucket) ||
            lowerMessage.contains(StoreSearchTerms.bucket))) {
      return _failure(
        StoreFailureType.invalidBucket,
        scope: scope,
        message: StoreMessages.invalidBucket,
        code: normalizedCode ?? StoreCodes.invalidBucket,
        retryable: false,
        packId: packId,
        fileId: fileId,
      );
    }
    if ((statusCode == 400 || statusCode == 404) &&
        ((lowerCode.contains(StoreSearchTerms.file) &&
                lowerCode.contains(StoreSearchTerms.invalid)) ||
            lowerMessage.contains(StoreSearchTerms.fileId) ||
            lowerMessage.contains(StoreSearchTerms.invalidFile))) {
      return _failure(
        StoreFailureType.invalidFileId,
        scope: scope,
        message: StoreMessages.invalidFileId,
        code: normalizedCode ?? StoreCodes.invalidFileId,
        retryable: false,
        packId: packId,
        fileId: fileId,
      );
    }
    if (statusCode != null && statusCode >= 500) {
      return _failure(
        StoreFailureType.server,
        scope: scope,
        message: normalizedMessage ?? StoreMessages.serverRequestFailed,
        code: normalizedCode ?? StoreCodes.serverError,
        retryable: true,
        packId: packId,
        fileId: fileId,
      );
    }
    return _failure(
      StoreFailureType.unknown,
      scope: scope,
      message: normalizedMessage ?? StoreMessages.requestFailed,
      code: normalizedCode ?? StoreCodes.unknown,
      retryable: true,
      packId: packId,
      fileId: fileId,
    );
  }

  StoreFailure? _failureFromCode(
    String code, {
    required StoreOperationScope scope,
    String? packId,
  }) {
    return switch (code) {
      StoreCodes.offline => _failure(
        StoreFailureType.offline,
        scope: scope,
        message: StoreMessages.offline,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.timeout => _failure(
        StoreFailureType.timeout,
        scope: scope,
        message: StoreMessages.requestTimedOut,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.badCertificate => _failure(
        StoreFailureType.badCertificate,
        scope: scope,
        message: StoreMessages.badCertificate,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.unauthorized => _failure(
        StoreFailureType.unauthorized,
        scope: scope,
        message: StoreMessages.assetsNotPublic,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.appwriteStorageFileNotFound ||
      StoreCodes.appwriteDocumentNotFound => _failure(
        StoreFailureType.notFound,
        scope: scope,
        message: StoreMessages.requestedFileNotFound,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.invalidBucket => _failure(
        StoreFailureType.invalidBucket,
        scope: scope,
        message: StoreMessages.invalidBucket,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.invalidFileId => _failure(
        StoreFailureType.invalidFileId,
        scope: scope,
        message: StoreMessages.invalidFileId,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.missingFile ||
      StoreCodes.missingThumbnail ||
      StoreCodes.missingSticker ||
      StoreCodes.missingTray => _failure(
        StoreFailureType.missingFile,
        scope: scope,
        message: StoreMessages.requiredAssetMissing,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.partialDownload => _failure(
        StoreFailureType.partialDownload,
        scope: scope,
        message: StoreMessages.partialDownload,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.duplicatePack => _failure(
        StoreFailureType.duplicatePack,
        scope: scope,
        message: StoreMessages.duplicatePack,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.outdatedLocalVersion => _failure(
        StoreFailureType.outdatedLocalVersion,
        scope: scope,
        message: StoreMessages.outdatedLocalVersion,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.insufficientStorage => _failure(
        StoreFailureType.insufficientStorage,
        scope: scope,
        message: StoreMessages.insufficientStorage,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.rateLimited => _failure(
        StoreFailureType.rateLimited,
        scope: scope,
        message: StoreMessages.requestsRateLimited,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.serverError => _failure(
        StoreFailureType.server,
        scope: scope,
        message: StoreMessages.serverRequestFailed,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.corruptAsset => _failure(
        StoreFailureType.corruptAsset,
        scope: scope,
        message: StoreMessages.corruptAsset,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.unsupportedFormat => _failure(
        StoreFailureType.unsupportedFormat,
        scope: scope,
        message: StoreMessages.unsupportedFormat,
        code: code,
        retryable: false,
        packId: packId,
      ),
      StoreCodes.validation => _failure(
        StoreFailureType.validation,
        scope: scope,
        message: StoreMessages.validationFailed,
        code: code,
        retryable: scope != StoreOperationScope.download,
        packId: packId,
      ),
      StoreCodes.storage => _failure(
        StoreFailureType.storage,
        scope: scope,
        message: StoreMessages.localPersistenceFailed,
        code: code,
        retryable: true,
        packId: packId,
      ),
      StoreCodes.cancelled => _failure(
        StoreFailureType.cancelled,
        scope: scope,
        message: StoreMessages.operationCancelled,
        code: code,
        retryable: true,
        packId: packId,
      ),
      _ => null,
    };
  }

  StoreFailure _failure(
    StoreFailureType type, {
    required StoreOperationScope scope,
    required String message,
    required String code,
    required bool retryable,
    String? packId,
    String? fileId,
    List<String> reasons = const <String>[],
  }) {
    return StoreFailure(
      type: type,
      scope: scope,
      message: message,
      code: code,
      retryable: retryable,
      packId: packId,
      fileId: fileId,
      reasons: reasons,
    );
  }
}

Map<String, Object?> _normalizeCatalogPayload((Uint8List, int) input) {
  final (bytes, supportedCatalogVersion) = input;
  final decoded = jsonDecode(utf8.decode(bytes));
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException(StoreMessages.catalogRootMustBeObject);
  }

  final version = (decoded[StoreJsonKeys.version] as num?)?.toInt();
  if (version == null || version < 1) {
    throw const FormatException(StoreMessages.catalogVersionInvalid);
  }

  final minVersion =
      (decoded[StoreJsonKeys.minimumCompatibleCatalogVersion] as num?)
          ?.toInt() ??
      (decoded[StoreJsonKeys.minCatalogVersion] as num?)?.toInt();
  if (minVersion != null && minVersion > supportedCatalogVersion) {
    throw const FormatException(StoreMessages.catalogVersionUnsupported);
  }

  final categories =
      ((decoded[StoreJsonKeys.categories] as List?) ?? const <Object?>[])
          .whereType<Map>()
          .map((entry) => _normalizeCategory(Map<String, dynamic>.from(entry)))
          .toList(growable: false);

  final issues = <Map<String, Object?>>[];
  final packs = <Map<String, Object?>>[];
  final seenPackIds = <String>{};

  for (final indexed
      in (((decoded[StoreJsonKeys.packs] as List?) ?? const <Object?>[]))
          .indexed) {
    final raw = indexed.$2;
    if (raw is! Map) {
      issues.add(<String, Object?>{
        StoreJsonKeys.packIndex: indexed.$1,
        StoreJsonKeys.type: StoreFailureType.invalidCatalog.name,
        StoreJsonKeys.message: StoreMessages.packEntryMustBeObject,
      });
      continue;
    }
    try {
      final pack = _normalizePack(Map<String, dynamic>.from(raw));
      if (!seenPackIds.add(pack[StoreJsonKeys.id]!.toString())) {
        throw const FormatException(StoreMessages.packIdMustBeUnique);
      }
      packs.add(pack);
    } on FormatException catch (error) {
      issues.add(<String, Object?>{
        StoreJsonKeys.packId: raw[StoreJsonKeys.id]?.toString(),
        StoreJsonKeys.packIndex: indexed.$1,
        StoreJsonKeys.type: StoreFailureType.invalidCatalog.name,
        StoreJsonKeys.message: error.message,
      });
    }
  }

  return <String, Object?>{
    StoreJsonKeys.version: version,
    StoreJsonKeys.updatedAt: decoded[StoreJsonKeys.updatedAt]?.toString(),
    StoreJsonKeys.categories: categories,
    StoreJsonKeys.packs: packs,
    StoreJsonKeys.issues: issues,
  };
}

Map<String, Object?> _normalizeCategory(Map<String, dynamic> raw) {
  final id = _requireIdentifier(raw, const <String>[StoreJsonKeys.id]);
  final name = _requireText(raw, const <String>[
    StoreJsonKeys.name,
    StoreJsonKeys.title,
  ]);
  final order =
      (raw[StoreJsonKeys.order] as num?)?.toInt() ??
      (raw[StoreJsonKeys.index] as num?)?.toInt() ??
      0;
  return <String, Object?>{
    StoreJsonKeys.id: id,
    StoreJsonKeys.name: name,
    StoreJsonKeys.order: order,
  };
}

Map<String, Object?> _normalizePack(Map<String, dynamic> raw) {
  final id = _requireIdentifier(raw, const <String>[
    StoreJsonKeys.id,
    StoreJsonKeys.packIdAlias,
    StoreJsonKeys.remoteId,
  ]);
  final version = _requireInt(raw, const <String>[StoreJsonKeys.version]);
  final name = _requireText(raw, const <String>[
    StoreJsonKeys.name,
    StoreJsonKeys.title,
  ]);
  final publisher = _requireText(raw, const <String>[
    StoreJsonKeys.publisher,
    StoreJsonKeys.author,
  ]);
  final trayFileId = _requireIdentifier(raw, const <String>[
    StoreJsonKeys.trayFileId,
    StoreJsonKeys.tray,
    StoreJsonKeys.trayFileIdSnake,
  ]);

  final rawStickers =
      raw[StoreJsonKeys.stickerFileIds] ??
      raw[StoreJsonKeys.stickers] ??
      raw[StoreJsonKeys.stickerFileIdsSnake];
  final stickerFileIds = _normalizeStickerFileIds(rawStickers);
  if (stickerFileIds.length < 3 || stickerFileIds.length > 30) {
    throw const FormatException(StoreMessages.stickersCountInvalid);
  }

  final categoryId = _optionalIdentifier(raw, const <String>[
    StoreJsonKeys.categoryId,
    StoreJsonKeys.category,
    StoreJsonKeys.categoryIdSnake,
  ]);
  final thumbnailFileId = _optionalIdentifier(raw, const <String>[
    StoreJsonKeys.thumbnailFileId,
    StoreJsonKeys.thumbnail,
    StoreJsonKeys.thumbnailFileIdSnake,
  ]);
  final featured = raw[StoreJsonKeys.featured] as bool? ?? false;
  final animated = raw[StoreJsonKeys.animated] as bool? ?? false;
  final sizeBytes =
      (raw[StoreJsonKeys.sizeBytes] as num?)?.toInt() ??
      (raw[StoreJsonKeys.size] as num?)?.toInt() ??
      0;
  final tags = ((raw[StoreJsonKeys.tags] as List?) ?? const <Object?>[])
      .map((value) => value.toString().trim())
      .where((value) => value.isNotEmpty)
      .toSet()
      .toList(growable: false);

  return <String, Object?>{
    StoreJsonKeys.id: id,
    StoreJsonKeys.version: version,
    StoreJsonKeys.name: name,
    StoreJsonKeys.publisher: publisher,
    StoreJsonKeys.categoryId: categoryId,
    StoreJsonKeys.featured: featured,
    StoreJsonKeys.trayFileId: trayFileId,
    StoreJsonKeys.stickerFileIds: stickerFileIds,
    StoreJsonKeys.thumbnailFileId: thumbnailFileId,
    StoreJsonKeys.animated: animated,
    StoreJsonKeys.tags: tags,
    StoreJsonKeys.sizeBytes: sizeBytes,
  };
}

List<String> _normalizeStickerFileIds(Object? raw) {
  final values = raw is List ? raw : const <Object?>[];
  final ids = <String>[];
  final seen = <String>{};
  for (final value in values) {
    final fileId = switch (value) {
      Map() => _optionalIdentifier(
        Map<String, dynamic>.from(value),
        const <String>[
          StoreJsonKeys.fileId,
          StoreJsonKeys.appwriteId,
          StoreJsonKeys.id,
        ],
      ),
      _ => value?.toString().trim(),
    };
    if (fileId == null || fileId.isEmpty) {
      throw const FormatException(StoreMessages.stickerFileIdInvalid);
    }
    if (!seen.add(fileId)) {
      throw const FormatException(StoreMessages.stickerFileIdsUnique);
    }
    ids.add(fileId);
  }
  return ids;
}

String _requireIdentifier(Map<String, dynamic> raw, List<String> keys) {
  final value = _optionalIdentifier(raw, keys);
  if (value == null || value.isEmpty) {
    throw FormatException(StoreMessages.missingField(keys.first));
  }
  return value;
}

String? _optionalIdentifier(Map<String, dynamic> raw, List<String> keys) {
  for (final key in keys) {
    final value = raw[key]?.toString().trim();
    if (value != null && value.isNotEmpty) {
      final sanitized = LibraryIds.sanitize(value);
      if (sanitized != value.toLowerCase()) {
        throw FormatException(StoreMessages.invalidField(key));
      }
      return value;
    }
  }
  return null;
}

String _requireText(Map<String, dynamic> raw, List<String> keys) {
  for (final key in keys) {
    final value = raw[key]?.toString().trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
  }
  throw FormatException(StoreMessages.missingField(keys.first));
}

int _requireInt(Map<String, dynamic> raw, List<String> keys) {
  for (final key in keys) {
    final value = (raw[key] as num?)?.toInt();
    if (value != null && value > 0) {
      return value;
    }
  }
  throw FormatException(StoreMessages.invalidField(keys.first));
}
