// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoreState {

 StoreCatalogStatus get status; StoreCatalog? get catalog; Map<String, StorePackDetail> get packDetails; Map<String, StoreLocalPackStatus> get localStatuses; Map<String, StoreDownloadProgress> get downloads; Map<String, StoreFailure> get packFailures; StoreFailure? get failure;
/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreStateCopyWith<StoreState> get copyWith => _$StoreStateCopyWithImpl<StoreState>(this as StoreState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreState&&(identical(other.status, status) || other.status == status)&&(identical(other.catalog, catalog) || other.catalog == catalog)&&const DeepCollectionEquality().equals(other.packDetails, packDetails)&&const DeepCollectionEquality().equals(other.localStatuses, localStatuses)&&const DeepCollectionEquality().equals(other.downloads, downloads)&&const DeepCollectionEquality().equals(other.packFailures, packFailures)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,catalog,const DeepCollectionEquality().hash(packDetails),const DeepCollectionEquality().hash(localStatuses),const DeepCollectionEquality().hash(downloads),const DeepCollectionEquality().hash(packFailures),failure);

@override
String toString() {
  return 'StoreState(status: $status, catalog: $catalog, packDetails: $packDetails, localStatuses: $localStatuses, downloads: $downloads, packFailures: $packFailures, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $StoreStateCopyWith<$Res>  {
  factory $StoreStateCopyWith(StoreState value, $Res Function(StoreState) _then) = _$StoreStateCopyWithImpl;
@useResult
$Res call({
 StoreCatalogStatus status, StoreCatalog? catalog, Map<String, StorePackDetail> packDetails, Map<String, StoreLocalPackStatus> localStatuses, Map<String, StoreDownloadProgress> downloads, Map<String, StoreFailure> packFailures, StoreFailure? failure
});


$StoreCatalogCopyWith<$Res>? get catalog;$StoreFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$StoreStateCopyWithImpl<$Res>
    implements $StoreStateCopyWith<$Res> {
  _$StoreStateCopyWithImpl(this._self, this._then);

  final StoreState _self;
  final $Res Function(StoreState) _then;

/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? catalog = freezed,Object? packDetails = null,Object? localStatuses = null,Object? downloads = null,Object? packFailures = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoreCatalogStatus,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as StoreCatalog?,packDetails: null == packDetails ? _self.packDetails : packDetails // ignore: cast_nullable_to_non_nullable
as Map<String, StorePackDetail>,localStatuses: null == localStatuses ? _self.localStatuses : localStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, StoreLocalPackStatus>,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as Map<String, StoreDownloadProgress>,packFailures: null == packFailures ? _self.packFailures : packFailures // ignore: cast_nullable_to_non_nullable
as Map<String, StoreFailure>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as StoreFailure?,
  ));
}
/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreCatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $StoreCatalogCopyWith<$Res>(_self.catalog!, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $StoreFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoreState].
extension StoreStatePatterns on StoreState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreState value)  $default,){
final _that = this;
switch (_that) {
case _StoreState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreState value)?  $default,){
final _that = this;
switch (_that) {
case _StoreState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoreCatalogStatus status,  StoreCatalog? catalog,  Map<String, StorePackDetail> packDetails,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StoreDownloadProgress> downloads,  Map<String, StoreFailure> packFailures,  StoreFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreState() when $default != null:
return $default(_that.status,_that.catalog,_that.packDetails,_that.localStatuses,_that.downloads,_that.packFailures,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoreCatalogStatus status,  StoreCatalog? catalog,  Map<String, StorePackDetail> packDetails,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StoreDownloadProgress> downloads,  Map<String, StoreFailure> packFailures,  StoreFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _StoreState():
return $default(_that.status,_that.catalog,_that.packDetails,_that.localStatuses,_that.downloads,_that.packFailures,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoreCatalogStatus status,  StoreCatalog? catalog,  Map<String, StorePackDetail> packDetails,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StoreDownloadProgress> downloads,  Map<String, StoreFailure> packFailures,  StoreFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _StoreState() when $default != null:
return $default(_that.status,_that.catalog,_that.packDetails,_that.localStatuses,_that.downloads,_that.packFailures,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _StoreState extends StoreState {
  const _StoreState({this.status = StoreCatalogStatus.initial, this.catalog,  Map<String, StorePackDetail> packDetails = const <String, StorePackDetail>{},  Map<String, StoreLocalPackStatus> localStatuses = const <String, StoreLocalPackStatus>{},  Map<String, StoreDownloadProgress> downloads = const <String, StoreDownloadProgress>{},  Map<String, StoreFailure> packFailures = const <String, StoreFailure>{}, this.failure}): _packDetails = packDetails,_localStatuses = localStatuses,_downloads = downloads,_packFailures = packFailures,super._();
  

@override@JsonKey() final  StoreCatalogStatus status;
@override final  StoreCatalog? catalog;
 final  Map<String, StorePackDetail> _packDetails;
@override@JsonKey() Map<String, StorePackDetail> get packDetails {
  if (_packDetails is EqualUnmodifiableMapView) return _packDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_packDetails);
}

 final  Map<String, StoreLocalPackStatus> _localStatuses;
@override@JsonKey() Map<String, StoreLocalPackStatus> get localStatuses {
  if (_localStatuses is EqualUnmodifiableMapView) return _localStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_localStatuses);
}

 final  Map<String, StoreDownloadProgress> _downloads;
@override@JsonKey() Map<String, StoreDownloadProgress> get downloads {
  if (_downloads is EqualUnmodifiableMapView) return _downloads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_downloads);
}

 final  Map<String, StoreFailure> _packFailures;
@override@JsonKey() Map<String, StoreFailure> get packFailures {
  if (_packFailures is EqualUnmodifiableMapView) return _packFailures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_packFailures);
}

@override final  StoreFailure? failure;

/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreStateCopyWith<_StoreState> get copyWith => __$StoreStateCopyWithImpl<_StoreState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreState&&(identical(other.status, status) || other.status == status)&&(identical(other.catalog, catalog) || other.catalog == catalog)&&const DeepCollectionEquality().equals(other._packDetails, _packDetails)&&const DeepCollectionEquality().equals(other._localStatuses, _localStatuses)&&const DeepCollectionEquality().equals(other._downloads, _downloads)&&const DeepCollectionEquality().equals(other._packFailures, _packFailures)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,catalog,const DeepCollectionEquality().hash(_packDetails),const DeepCollectionEquality().hash(_localStatuses),const DeepCollectionEquality().hash(_downloads),const DeepCollectionEquality().hash(_packFailures),failure);

@override
String toString() {
  return 'StoreState(status: $status, catalog: $catalog, packDetails: $packDetails, localStatuses: $localStatuses, downloads: $downloads, packFailures: $packFailures, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$StoreStateCopyWith<$Res> implements $StoreStateCopyWith<$Res> {
  factory _$StoreStateCopyWith(_StoreState value, $Res Function(_StoreState) _then) = __$StoreStateCopyWithImpl;
@override @useResult
$Res call({
 StoreCatalogStatus status, StoreCatalog? catalog, Map<String, StorePackDetail> packDetails, Map<String, StoreLocalPackStatus> localStatuses, Map<String, StoreDownloadProgress> downloads, Map<String, StoreFailure> packFailures, StoreFailure? failure
});


@override $StoreCatalogCopyWith<$Res>? get catalog;@override $StoreFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$StoreStateCopyWithImpl<$Res>
    implements _$StoreStateCopyWith<$Res> {
  __$StoreStateCopyWithImpl(this._self, this._then);

  final _StoreState _self;
  final $Res Function(_StoreState) _then;

/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? catalog = freezed,Object? packDetails = null,Object? localStatuses = null,Object? downloads = null,Object? packFailures = null,Object? failure = freezed,}) {
  return _then(_StoreState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoreCatalogStatus,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as StoreCatalog?,packDetails: null == packDetails ? _self._packDetails : packDetails // ignore: cast_nullable_to_non_nullable
as Map<String, StorePackDetail>,localStatuses: null == localStatuses ? _self._localStatuses : localStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, StoreLocalPackStatus>,downloads: null == downloads ? _self._downloads : downloads // ignore: cast_nullable_to_non_nullable
as Map<String, StoreDownloadProgress>,packFailures: null == packFailures ? _self._packFailures : packFailures // ignore: cast_nullable_to_non_nullable
as Map<String, StoreFailure>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as StoreFailure?,
  ));
}

/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreCatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $StoreCatalogCopyWith<$Res>(_self.catalog!, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}/// Create a copy of StoreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $StoreFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
