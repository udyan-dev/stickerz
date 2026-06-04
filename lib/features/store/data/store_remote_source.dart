import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/config/appwrite_config.dart';
import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../domain/store_models.dart';
import 'store_mapper.dart';

abstract interface class StoreRemoteSource {
  Future<AppResult<StoreCatalog>> fetchCatalog({CancelToken? cancelToken});

  Future<AppResult<StoreRemoteFileInfo>> fetchFileInfo(
    String fileId, {
    CancelToken? cancelToken,
  });

  Future<AppResult<void>> downloadFile({
    required String fileId,
    required String destinationPath,
    CancelToken? cancelToken,
    void Function(int received, int total)? onReceiveProgress,
  });
}

class AppwriteStoreRemoteSource implements StoreRemoteSource {
  AppwriteStoreRemoteSource(this._dio, this._config, this._mapper)
    : _jsonOptions = Options(responseType: ResponseType.json),
      _bytesOptions = Options(responseType: ResponseType.bytes),
      _streamOptions = Options(responseType: ResponseType.stream);

  final Dio _dio;
  final AppwriteConfig _config;
  final StoreMapper _mapper;
  final Options _jsonOptions;
  final Options _bytesOptions;
  final Options _streamOptions;

  @override
  Future<AppResult<StoreCatalog>> fetchCatalog({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.getUri<List<int>>(
        _config.catalogDownloadUri,
        options: _bytesOptions,
        cancelToken: cancelToken,
      );
      final bytes = Uint8List.fromList(response.data ?? const <int>[]);
      if (bytes.isEmpty) {
        return AppResult.failure(
          AppError.parse(
            message: StoreMessages.catalogEmpty,
            code: StoreCodes.invalidCatalog,
          ),
        );
      }
      return _mapper.mapCatalogBytes(bytes);
    } on DioException catch (error) {
      return AppResult.failure(
        _mapper.toAppError(
          _mapper.failureFromDioException(
            error,
            scope: StoreOperationScope.catalog,
          ),
        ),
      );
    } on Object catch (error) {
      return AppResult.failure(
        AppError.unknown(
          message: StoreMessages.catalogLoadFailed,
          code: StoreCodes.catalogFailed,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  @override
  Future<AppResult<StoreRemoteFileInfo>> fetchFileInfo(
    String fileId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.getUri<Map<String, dynamic>>(
        _config.storageFileUri(fileId),
        options: _jsonOptions,
        cancelToken: cancelToken,
      );
      final data = response.data ?? const <String, dynamic>{};
      return _mapper.mapRemoteFileInfo(data, fileId: fileId);
    } on DioException catch (error) {
      return AppResult.failure(
        _mapper.toAppError(
          _mapper.failureFromDioException(
            error,
            scope: StoreOperationScope.download,
            fileId: fileId,
          ),
        ),
      );
    } on Object catch (error) {
      return AppResult.failure(
        AppError.unknown(
          message: StoreMessages.remoteFileMetadataLoadFailed,
          code: StoreCodes.invalidFileInfo,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> downloadFile({
    required String fileId,
    required String destinationPath,
    CancelToken? cancelToken,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    IOSink? sink;
    final file = File(destinationPath);
    try {
      final response = await _dio.getUri<ResponseBody>(
        _config.storageDownloadUri(fileId),
        options: _streamOptions,
        cancelToken: cancelToken,
      );
      final body = response.data;
      if (body == null) {
        return AppResult.failure(
          AppError.storage(
            message: StoreMessages.downloadWriteFailed,
            code: StoreCodes.partialDownload,
          ),
        );
      }
      await file.parent.create(recursive: true);
      sink = file.openWrite();
      var received = 0;
      final total = body.contentLength;
      await for (final chunk in body.stream) {
        if (cancelToken?.isCancelled ?? false) {
          throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            error: cancelToken?.cancelError,
          );
        }
        sink.add(chunk);
        received += chunk.length;
        onReceiveProgress?.call(received, total);
      }
      await sink.flush();
      await sink.close();
      return const AppResult.success(null);
    } on DioException catch (error) {
      await sink?.close();
      await _deletePartialFile(file.path);
      return AppResult.failure(
        _mapper.toAppError(
          _mapper.failureFromDioException(
            error,
            scope: StoreOperationScope.download,
            fileId: fileId,
          ),
        ),
      );
    } on FileSystemException catch (error) {
      await sink?.close();
      await _deletePartialFile(file.path);
      return AppResult.failure(
        AppError.storage(
          message: StoreMessages.downloadDiskWriteFailed,
          path: error.path,
          code: StoreCodes.insufficientStorage,
          debugDetails: error.toString(),
        ),
      );
    } on Object catch (error) {
      await sink?.close();
      await _deletePartialFile(file.path);
      return AppResult.failure(
        AppError.unknown(
          message: StoreMessages.downloadWriteFailed,
          code: StoreCodes.unknown,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<void> _deletePartialFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } on Object {
      return;
    }
  }
}
