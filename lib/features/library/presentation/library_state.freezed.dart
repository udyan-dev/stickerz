// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryState {

 List<StickerPack> get packs; Map<String, AppError> get invalidPacks; bool get loading; bool get importing; String? get exportingPackId; String? get sharingPackId; String? get importedPackId; WhatsAppAddResult? get waStatus; AppError? get error; ProcessResult? get lastSavedSticker; ProcessResult? get lastSavedTray;
/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryStateCopyWith<LibraryState> get copyWith => _$LibraryStateCopyWithImpl<LibraryState>(this as LibraryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryState&&const DeepCollectionEquality().equals(other.packs, packs)&&const DeepCollectionEquality().equals(other.invalidPacks, invalidPacks)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.importing, importing) || other.importing == importing)&&(identical(other.exportingPackId, exportingPackId) || other.exportingPackId == exportingPackId)&&(identical(other.sharingPackId, sharingPackId) || other.sharingPackId == sharingPackId)&&(identical(other.importedPackId, importedPackId) || other.importedPackId == importedPackId)&&(identical(other.waStatus, waStatus) || other.waStatus == waStatus)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastSavedSticker, lastSavedSticker) || other.lastSavedSticker == lastSavedSticker)&&(identical(other.lastSavedTray, lastSavedTray) || other.lastSavedTray == lastSavedTray));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(packs),const DeepCollectionEquality().hash(invalidPacks),loading,importing,exportingPackId,sharingPackId,importedPackId,waStatus,error,lastSavedSticker,lastSavedTray);

@override
String toString() {
  return 'LibraryState(packs: $packs, invalidPacks: $invalidPacks, loading: $loading, importing: $importing, exportingPackId: $exportingPackId, sharingPackId: $sharingPackId, importedPackId: $importedPackId, waStatus: $waStatus, error: $error, lastSavedSticker: $lastSavedSticker, lastSavedTray: $lastSavedTray)';
}


}

/// @nodoc
abstract mixin class $LibraryStateCopyWith<$Res>  {
  factory $LibraryStateCopyWith(LibraryState value, $Res Function(LibraryState) _then) = _$LibraryStateCopyWithImpl;
@useResult
$Res call({
 List<StickerPack> packs, Map<String, AppError> invalidPacks, bool loading, bool importing, String? exportingPackId, String? sharingPackId, String? importedPackId, WhatsAppAddResult? waStatus, AppError? error, ProcessResult? lastSavedSticker, ProcessResult? lastSavedTray
});


$WhatsAppAddResultCopyWith<$Res>? get waStatus;$ProcessResultCopyWith<$Res>? get lastSavedSticker;$ProcessResultCopyWith<$Res>? get lastSavedTray;

}
/// @nodoc
class _$LibraryStateCopyWithImpl<$Res>
    implements $LibraryStateCopyWith<$Res> {
  _$LibraryStateCopyWithImpl(this._self, this._then);

  final LibraryState _self;
  final $Res Function(LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packs = null,Object? invalidPacks = null,Object? loading = null,Object? importing = null,Object? exportingPackId = freezed,Object? sharingPackId = freezed,Object? importedPackId = freezed,Object? waStatus = freezed,Object? error = freezed,Object? lastSavedSticker = freezed,Object? lastSavedTray = freezed,}) {
  return _then(_self.copyWith(
packs: null == packs ? _self.packs : packs // ignore: cast_nullable_to_non_nullable
as List<StickerPack>,invalidPacks: null == invalidPacks ? _self.invalidPacks : invalidPacks // ignore: cast_nullable_to_non_nullable
as Map<String, AppError>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,importing: null == importing ? _self.importing : importing // ignore: cast_nullable_to_non_nullable
as bool,exportingPackId: freezed == exportingPackId ? _self.exportingPackId : exportingPackId // ignore: cast_nullable_to_non_nullable
as String?,sharingPackId: freezed == sharingPackId ? _self.sharingPackId : sharingPackId // ignore: cast_nullable_to_non_nullable
as String?,importedPackId: freezed == importedPackId ? _self.importedPackId : importedPackId // ignore: cast_nullable_to_non_nullable
as String?,waStatus: freezed == waStatus ? _self.waStatus : waStatus // ignore: cast_nullable_to_non_nullable
as WhatsAppAddResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,lastSavedSticker: freezed == lastSavedSticker ? _self.lastSavedSticker : lastSavedSticker // ignore: cast_nullable_to_non_nullable
as ProcessResult?,lastSavedTray: freezed == lastSavedTray ? _self.lastSavedTray : lastSavedTray // ignore: cast_nullable_to_non_nullable
as ProcessResult?,
  ));
}
/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WhatsAppAddResultCopyWith<$Res>? get waStatus {
    if (_self.waStatus == null) {
    return null;
  }

  return $WhatsAppAddResultCopyWith<$Res>(_self.waStatus!, (value) {
    return _then(_self.copyWith(waStatus: value));
  });
}/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastSavedSticker {
    if (_self.lastSavedSticker == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastSavedSticker!, (value) {
    return _then(_self.copyWith(lastSavedSticker: value));
  });
}/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastSavedTray {
    if (_self.lastSavedTray == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastSavedTray!, (value) {
    return _then(_self.copyWith(lastSavedTray: value));
  });
}
}


/// Adds pattern-matching-related methods to [LibraryState].
extension LibraryStatePatterns on LibraryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryState value)  $default,){
final _that = this;
switch (_that) {
case _LibraryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryState value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StickerPack> packs,  Map<String, AppError> invalidPacks,  bool loading,  bool importing,  String? exportingPackId,  String? sharingPackId,  String? importedPackId,  WhatsAppAddResult? waStatus,  AppError? error,  ProcessResult? lastSavedSticker,  ProcessResult? lastSavedTray)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.packs,_that.invalidPacks,_that.loading,_that.importing,_that.exportingPackId,_that.sharingPackId,_that.importedPackId,_that.waStatus,_that.error,_that.lastSavedSticker,_that.lastSavedTray);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StickerPack> packs,  Map<String, AppError> invalidPacks,  bool loading,  bool importing,  String? exportingPackId,  String? sharingPackId,  String? importedPackId,  WhatsAppAddResult? waStatus,  AppError? error,  ProcessResult? lastSavedSticker,  ProcessResult? lastSavedTray)  $default,) {final _that = this;
switch (_that) {
case _LibraryState():
return $default(_that.packs,_that.invalidPacks,_that.loading,_that.importing,_that.exportingPackId,_that.sharingPackId,_that.importedPackId,_that.waStatus,_that.error,_that.lastSavedSticker,_that.lastSavedTray);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StickerPack> packs,  Map<String, AppError> invalidPacks,  bool loading,  bool importing,  String? exportingPackId,  String? sharingPackId,  String? importedPackId,  WhatsAppAddResult? waStatus,  AppError? error,  ProcessResult? lastSavedSticker,  ProcessResult? lastSavedTray)?  $default,) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.packs,_that.invalidPacks,_that.loading,_that.importing,_that.exportingPackId,_that.sharingPackId,_that.importedPackId,_that.waStatus,_that.error,_that.lastSavedSticker,_that.lastSavedTray);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryState implements LibraryState {
  const _LibraryState({ List<StickerPack> packs = const <StickerPack>[],  Map<String, AppError> invalidPacks = const <String, AppError>{}, this.loading = false, this.importing = false, this.exportingPackId, this.sharingPackId, this.importedPackId, this.waStatus, this.error, this.lastSavedSticker, this.lastSavedTray}): _packs = packs,_invalidPacks = invalidPacks;
  

 final  List<StickerPack> _packs;
@override@JsonKey() List<StickerPack> get packs {
  if (_packs is EqualUnmodifiableListView) return _packs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packs);
}

 final  Map<String, AppError> _invalidPacks;
@override@JsonKey() Map<String, AppError> get invalidPacks {
  if (_invalidPacks is EqualUnmodifiableMapView) return _invalidPacks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_invalidPacks);
}

@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool importing;
@override final  String? exportingPackId;
@override final  String? sharingPackId;
@override final  String? importedPackId;
@override final  WhatsAppAddResult? waStatus;
@override final  AppError? error;
@override final  ProcessResult? lastSavedSticker;
@override final  ProcessResult? lastSavedTray;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryStateCopyWith<_LibraryState> get copyWith => __$LibraryStateCopyWithImpl<_LibraryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryState&&const DeepCollectionEquality().equals(other._packs, _packs)&&const DeepCollectionEquality().equals(other._invalidPacks, _invalidPacks)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.importing, importing) || other.importing == importing)&&(identical(other.exportingPackId, exportingPackId) || other.exportingPackId == exportingPackId)&&(identical(other.sharingPackId, sharingPackId) || other.sharingPackId == sharingPackId)&&(identical(other.importedPackId, importedPackId) || other.importedPackId == importedPackId)&&(identical(other.waStatus, waStatus) || other.waStatus == waStatus)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastSavedSticker, lastSavedSticker) || other.lastSavedSticker == lastSavedSticker)&&(identical(other.lastSavedTray, lastSavedTray) || other.lastSavedTray == lastSavedTray));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_packs),const DeepCollectionEquality().hash(_invalidPacks),loading,importing,exportingPackId,sharingPackId,importedPackId,waStatus,error,lastSavedSticker,lastSavedTray);

@override
String toString() {
  return 'LibraryState(packs: $packs, invalidPacks: $invalidPacks, loading: $loading, importing: $importing, exportingPackId: $exportingPackId, sharingPackId: $sharingPackId, importedPackId: $importedPackId, waStatus: $waStatus, error: $error, lastSavedSticker: $lastSavedSticker, lastSavedTray: $lastSavedTray)';
}


}

/// @nodoc
abstract mixin class _$LibraryStateCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$LibraryStateCopyWith(_LibraryState value, $Res Function(_LibraryState) _then) = __$LibraryStateCopyWithImpl;
@override @useResult
$Res call({
 List<StickerPack> packs, Map<String, AppError> invalidPacks, bool loading, bool importing, String? exportingPackId, String? sharingPackId, String? importedPackId, WhatsAppAddResult? waStatus, AppError? error, ProcessResult? lastSavedSticker, ProcessResult? lastSavedTray
});


@override $WhatsAppAddResultCopyWith<$Res>? get waStatus;@override $ProcessResultCopyWith<$Res>? get lastSavedSticker;@override $ProcessResultCopyWith<$Res>? get lastSavedTray;

}
/// @nodoc
class __$LibraryStateCopyWithImpl<$Res>
    implements _$LibraryStateCopyWith<$Res> {
  __$LibraryStateCopyWithImpl(this._self, this._then);

  final _LibraryState _self;
  final $Res Function(_LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packs = null,Object? invalidPacks = null,Object? loading = null,Object? importing = null,Object? exportingPackId = freezed,Object? sharingPackId = freezed,Object? importedPackId = freezed,Object? waStatus = freezed,Object? error = freezed,Object? lastSavedSticker = freezed,Object? lastSavedTray = freezed,}) {
  return _then(_LibraryState(
packs: null == packs ? _self._packs : packs // ignore: cast_nullable_to_non_nullable
as List<StickerPack>,invalidPacks: null == invalidPacks ? _self._invalidPacks : invalidPacks // ignore: cast_nullable_to_non_nullable
as Map<String, AppError>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,importing: null == importing ? _self.importing : importing // ignore: cast_nullable_to_non_nullable
as bool,exportingPackId: freezed == exportingPackId ? _self.exportingPackId : exportingPackId // ignore: cast_nullable_to_non_nullable
as String?,sharingPackId: freezed == sharingPackId ? _self.sharingPackId : sharingPackId // ignore: cast_nullable_to_non_nullable
as String?,importedPackId: freezed == importedPackId ? _self.importedPackId : importedPackId // ignore: cast_nullable_to_non_nullable
as String?,waStatus: freezed == waStatus ? _self.waStatus : waStatus // ignore: cast_nullable_to_non_nullable
as WhatsAppAddResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,lastSavedSticker: freezed == lastSavedSticker ? _self.lastSavedSticker : lastSavedSticker // ignore: cast_nullable_to_non_nullable
as ProcessResult?,lastSavedTray: freezed == lastSavedTray ? _self.lastSavedTray : lastSavedTray // ignore: cast_nullable_to_non_nullable
as ProcessResult?,
  ));
}

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WhatsAppAddResultCopyWith<$Res>? get waStatus {
    if (_self.waStatus == null) {
    return null;
  }

  return $WhatsAppAddResultCopyWith<$Res>(_self.waStatus!, (value) {
    return _then(_self.copyWith(waStatus: value));
  });
}/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastSavedSticker {
    if (_self.lastSavedSticker == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastSavedSticker!, (value) {
    return _then(_self.copyWith(lastSavedSticker: value));
  });
}/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastSavedTray {
    if (_self.lastSavedTray == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastSavedTray!, (value) {
    return _then(_self.copyWith(lastSavedTray: value));
  });
}
}

// dart format on
