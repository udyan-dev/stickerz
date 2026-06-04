import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/store_models.dart';

part 'store_state.freezed.dart';

@freezed
abstract class StoreState with _$StoreState {
  const StoreState._();

  const factory StoreState({
    @Default(StoreCatalogStatus.initial) StoreCatalogStatus status,
    StoreCatalog? catalog,
    @Default(<String, StorePackDetail>{})
    Map<String, StorePackDetail> packDetails,
    @Default(<String, StoreLocalPackStatus>{})
    Map<String, StoreLocalPackStatus> localStatuses,
    @Default(<String, StoreDownloadProgress>{})
    Map<String, StoreDownloadProgress> downloads,
    @Default(<String, StoreFailure>{}) Map<String, StoreFailure> packFailures,
    StoreFailure? failure,
  }) = _StoreState;

  bool get hasCatalog => catalog != null;

  bool get isEmpty => status == StoreCatalogStatus.empty;
}
