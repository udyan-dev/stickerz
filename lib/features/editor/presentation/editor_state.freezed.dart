// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorState {

 bool get processing; String? get pickedImagePath; ProcessResult? get lastStickerResult; ProcessResult? get lastTrayResult; AppError? get error;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.pickedImagePath, pickedImagePath) || other.pickedImagePath == pickedImagePath)&&(identical(other.lastStickerResult, lastStickerResult) || other.lastStickerResult == lastStickerResult)&&(identical(other.lastTrayResult, lastTrayResult) || other.lastTrayResult == lastTrayResult)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,processing,pickedImagePath,lastStickerResult,lastTrayResult,error);

@override
String toString() {
  return 'EditorState(processing: $processing, pickedImagePath: $pickedImagePath, lastStickerResult: $lastStickerResult, lastTrayResult: $lastTrayResult, error: $error)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 bool processing, String? pickedImagePath, ProcessResult? lastStickerResult, ProcessResult? lastTrayResult, AppError? error
});


$ProcessResultCopyWith<$Res>? get lastStickerResult;$ProcessResultCopyWith<$Res>? get lastTrayResult;

}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processing = null,Object? pickedImagePath = freezed,Object? lastStickerResult = freezed,Object? lastTrayResult = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,pickedImagePath: freezed == pickedImagePath ? _self.pickedImagePath : pickedImagePath // ignore: cast_nullable_to_non_nullable
as String?,lastStickerResult: freezed == lastStickerResult ? _self.lastStickerResult : lastStickerResult // ignore: cast_nullable_to_non_nullable
as ProcessResult?,lastTrayResult: freezed == lastTrayResult ? _self.lastTrayResult : lastTrayResult // ignore: cast_nullable_to_non_nullable
as ProcessResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,
  ));
}
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastStickerResult {
    if (_self.lastStickerResult == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastStickerResult!, (value) {
    return _then(_self.copyWith(lastStickerResult: value));
  });
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastTrayResult {
    if (_self.lastTrayResult == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastTrayResult!, (value) {
    return _then(_self.copyWith(lastTrayResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditorState value)  $default,){
final _that = this;
switch (_that) {
case _EditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditorState value)?  $default,){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool processing,  String? pickedImagePath,  ProcessResult? lastStickerResult,  ProcessResult? lastTrayResult,  AppError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.processing,_that.pickedImagePath,_that.lastStickerResult,_that.lastTrayResult,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool processing,  String? pickedImagePath,  ProcessResult? lastStickerResult,  ProcessResult? lastTrayResult,  AppError? error)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.processing,_that.pickedImagePath,_that.lastStickerResult,_that.lastTrayResult,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool processing,  String? pickedImagePath,  ProcessResult? lastStickerResult,  ProcessResult? lastTrayResult,  AppError? error)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.processing,_that.pickedImagePath,_that.lastStickerResult,_that.lastTrayResult,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _EditorState implements EditorState {
  const _EditorState({this.processing = false, this.pickedImagePath, this.lastStickerResult, this.lastTrayResult, this.error});
  

@override@JsonKey() final  bool processing;
@override final  String? pickedImagePath;
@override final  ProcessResult? lastStickerResult;
@override final  ProcessResult? lastTrayResult;
@override final  AppError? error;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.pickedImagePath, pickedImagePath) || other.pickedImagePath == pickedImagePath)&&(identical(other.lastStickerResult, lastStickerResult) || other.lastStickerResult == lastStickerResult)&&(identical(other.lastTrayResult, lastTrayResult) || other.lastTrayResult == lastTrayResult)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,processing,pickedImagePath,lastStickerResult,lastTrayResult,error);

@override
String toString() {
  return 'EditorState(processing: $processing, pickedImagePath: $pickedImagePath, lastStickerResult: $lastStickerResult, lastTrayResult: $lastTrayResult, error: $error)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 bool processing, String? pickedImagePath, ProcessResult? lastStickerResult, ProcessResult? lastTrayResult, AppError? error
});


@override $ProcessResultCopyWith<$Res>? get lastStickerResult;@override $ProcessResultCopyWith<$Res>? get lastTrayResult;

}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processing = null,Object? pickedImagePath = freezed,Object? lastStickerResult = freezed,Object? lastTrayResult = freezed,Object? error = freezed,}) {
  return _then(_EditorState(
processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,pickedImagePath: freezed == pickedImagePath ? _self.pickedImagePath : pickedImagePath // ignore: cast_nullable_to_non_nullable
as String?,lastStickerResult: freezed == lastStickerResult ? _self.lastStickerResult : lastStickerResult // ignore: cast_nullable_to_non_nullable
as ProcessResult?,lastTrayResult: freezed == lastTrayResult ? _self.lastTrayResult : lastTrayResult // ignore: cast_nullable_to_non_nullable
as ProcessResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,
  ));
}

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastStickerResult {
    if (_self.lastStickerResult == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastStickerResult!, (value) {
    return _then(_self.copyWith(lastStickerResult: value));
  });
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<$Res>? get lastTrayResult {
    if (_self.lastTrayResult == null) {
    return null;
  }

  return $ProcessResultCopyWith<$Res>(_self.lastTrayResult!, (value) {
    return _then(_self.copyWith(lastTrayResult: value));
  });
}
}

// dart format on
