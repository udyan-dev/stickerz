import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/util/constants/constants.dart';
import '../data/store_mapper.dart';
import '../data/store_repository.dart';
import '../domain/store_models.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._repository, this._mapper) : super(const StoreState());

  final StoreRepository _repository;
  final StoreMapper _mapper;
  CancelToken? _catalogToken;
  final Map<String, CancelToken> _detailTokens = <String, CancelToken>{};
  final Map<String, CancelToken> _downloadTokens = <String, CancelToken>{};

  Future<void> load() async {
    _catalogToken?.cancel(StoreControlReasons.replaced);
    final cancelToken = CancelToken();
    _catalogToken = cancelToken;
    final nextStatus = state.catalog == null
        ? StoreCatalogStatus.loading
        : state.status;
    _emitIfChanged(state.copyWith(status: nextStatus, failure: null));
    final result = await _repository.refreshCatalog(cancelToken: cancelToken);
    if (!identical(_catalogToken, cancelToken)) {
      return;
    }
    _catalogToken = null;
    if (result.isFailure) {
      final failure = _mapper.failureFromAppError(
        result.errorOrNull!,
        scope: StoreOperationScope.catalog,
      );
      if (failure.type == StoreFailureType.cancelled) {
        return;
      }
      _emitIfChanged(
        state.copyWith(
          status: state.catalog == null
              ? StoreCatalogStatus.error
              : state.status,
          failure: failure,
        ),
      );
      return;
    }
    _applySnapshot(result.valueOrNull!);
  }

  Future<void> refreshLocalStatus() async {
    final result = await _repository.refreshLocalStatus();
    if (result.isFailure) {
      _emitIfChanged(
        state.copyWith(
          failure: _mapper.failureFromAppError(
            result.errorOrNull!,
            scope: StoreOperationScope.localSync,
          ),
        ),
      );
      return;
    }
    _applySnapshot(result.valueOrNull!, preserveFailure: true);
  }

  Future<void> resolvePackDetail(String packId) async {
    _detailTokens.remove(packId)?.cancel(StoreControlReasons.replaced);
    final cancelToken = CancelToken();
    _detailTokens[packId] = cancelToken;
    final result = await _repository.resolvePackDetail(
      packId,
      cancelToken: cancelToken,
    );
    if (!identical(_detailTokens[packId], cancelToken)) {
      return;
    }
    _detailTokens.remove(packId);
    if (result.isFailure) {
      final failure = _mapper.failureFromAppError(
        result.errorOrNull!,
        scope: StoreOperationScope.detail,
        packId: packId,
      );
      if (failure.type == StoreFailureType.cancelled) {
        return;
      }
      _emitIfChanged(
        state.copyWith(
          packFailures: Map<String, StoreFailure>.from(state.packFailures)
            ..[packId] = failure,
        ),
      );
      return;
    }
    final details = Map<String, StorePackDetail>.from(state.packDetails)
      ..[packId] = result.valueOrNull!;
    _emitIfChanged(
      state.copyWith(
        packDetails: details,
        packFailures: Map<String, StoreFailure>.from(state.packFailures)
          ..remove(packId),
      ),
    );
  }

  Future<void> downloadPack(String packId) async {
    if (_downloadTokens.containsKey(packId)) {
      return;
    }
    final cancelToken = CancelToken();
    _downloadTokens[packId] = cancelToken;
    _emitIfChanged(
      state.copyWith(
        packFailures: Map<String, StoreFailure>.from(state.packFailures)
          ..remove(packId),
        downloads: Map<String, StoreDownloadProgress>.from(state.downloads)
          ..[packId] = StoreDownloadProgress(packId: packId),
      ),
    );

    final result = await _repository.downloadPack(
      packId,
      cancelToken: cancelToken,
      onProgress: (progress) {
        if (!identical(_downloadTokens[packId], cancelToken) || isClosed) {
          return;
        }
        if (state.downloads[packId] == progress) {
          return;
        }
        _emitIfChanged(
          state.copyWith(
            downloads: Map<String, StoreDownloadProgress>.from(state.downloads)
              ..[packId] = progress,
          ),
        );
      },
    );

    if (!identical(_downloadTokens[packId], cancelToken)) {
      return;
    }
    _downloadTokens.remove(packId);
    final downloads = Map<String, StoreDownloadProgress>.from(state.downloads)
      ..remove(packId);

    if (result.isFailure) {
      final failure = _mapper.failureFromAppError(
        result.errorOrNull!,
        scope: StoreOperationScope.download,
        packId: packId,
      );
      final packFailures = Map<String, StoreFailure>.from(state.packFailures);
      if (failure.type == StoreFailureType.cancelled) {
        packFailures.remove(packId);
      } else {
        packFailures[packId] = failure;
      }
      _emitIfChanged(
        state.copyWith(downloads: downloads, packFailures: packFailures),
      );
      return;
    }

    final updatedDetail = result.valueOrNull!;
    _emitIfChanged(
      state.copyWith(
        downloads: downloads,
        packDetails: Map<String, StorePackDetail>.from(state.packDetails)
          ..[packId] = updatedDetail,
        localStatuses: Map<String, StoreLocalPackStatus>.from(
          state.localStatuses,
        )..[packId] = updatedDetail.localStatus,
        packFailures: Map<String, StoreFailure>.from(state.packFailures)
          ..remove(packId),
      ),
    );
  }

  void cancelDownload(String packId) {
    _downloadTokens[packId]?.cancel(StoreControlReasons.cancelled);
  }

  Future<void> retryCatalog() => load();

  Future<void> retryPack(String packId) async {
    final failure = state.packFailures[packId];
    if (failure == null) {
      return;
    }
    if (failure.scope == StoreOperationScope.download ||
        failure.scope == StoreOperationScope.repair) {
      await downloadPack(packId);
      return;
    }
    await resolvePackDetail(packId);
  }

  @override
  Future<void> close() {
    _catalogToken?.cancel(StoreControlReasons.disposed);
    _catalogToken = null;
    for (final token in _detailTokens.values) {
      token.cancel(StoreControlReasons.disposed);
    }
    _detailTokens.clear();
    for (final token in _downloadTokens.values) {
      token.cancel(StoreControlReasons.disposed);
    }
    _downloadTokens.clear();
    return super.close();
  }

  void _applySnapshot(
    StoreCatalogSnapshot snapshot, {
    bool preserveFailure = false,
  }) {
    _emitIfChanged(
      state.copyWith(
        status: snapshot.catalog.isEmpty
            ? StoreCatalogStatus.empty
            : StoreCatalogStatus.success,
        catalog: snapshot.catalog,
        packDetails: snapshot.packDetails,
        localStatuses: snapshot.localStatuses,
        failure: preserveFailure ? state.failure : null,
      ),
    );
  }

  void _emitIfChanged(StoreState nextState) {
    if (!isClosed && nextState != state) {
      emit(nextState);
    }
  }
}
