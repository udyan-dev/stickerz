// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whatsapp_add_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WhatsAppAddResult {

 WhatsAppAddStatus get status; String? get validationError;
/// Create a copy of WhatsAppAddResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatsAppAddResultCopyWith<WhatsAppAddResult> get copyWith => _$WhatsAppAddResultCopyWithImpl<WhatsAppAddResult>(this as WhatsAppAddResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatsAppAddResult&&(identical(other.status, status) || other.status == status)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,status,validationError);

@override
String toString() {
  return 'WhatsAppAddResult(status: $status, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class $WhatsAppAddResultCopyWith<$Res>  {
  factory $WhatsAppAddResultCopyWith(WhatsAppAddResult value, $Res Function(WhatsAppAddResult) _then) = _$WhatsAppAddResultCopyWithImpl;
@useResult
$Res call({
 WhatsAppAddStatus status, String? validationError
});




}
/// @nodoc
class _$WhatsAppAddResultCopyWithImpl<$Res>
    implements $WhatsAppAddResultCopyWith<$Res> {
  _$WhatsAppAddResultCopyWithImpl(this._self, this._then);

  final WhatsAppAddResult _self;
  final $Res Function(WhatsAppAddResult) _then;

/// Create a copy of WhatsAppAddResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? validationError = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WhatsAppAddStatus,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WhatsAppAddResult].
extension WhatsAppAddResultPatterns on WhatsAppAddResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatsAppAddResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatsAppAddResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatsAppAddResult value)  $default,){
final _that = this;
switch (_that) {
case _WhatsAppAddResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatsAppAddResult value)?  $default,){
final _that = this;
switch (_that) {
case _WhatsAppAddResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WhatsAppAddStatus status,  String? validationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatsAppAddResult() when $default != null:
return $default(_that.status,_that.validationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WhatsAppAddStatus status,  String? validationError)  $default,) {final _that = this;
switch (_that) {
case _WhatsAppAddResult():
return $default(_that.status,_that.validationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WhatsAppAddStatus status,  String? validationError)?  $default,) {final _that = this;
switch (_that) {
case _WhatsAppAddResult() when $default != null:
return $default(_that.status,_that.validationError);case _:
  return null;

}
}

}

/// @nodoc


class _WhatsAppAddResult implements WhatsAppAddResult {
  const _WhatsAppAddResult({required this.status, this.validationError});
  

@override final  WhatsAppAddStatus status;
@override final  String? validationError;

/// Create a copy of WhatsAppAddResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatsAppAddResultCopyWith<_WhatsAppAddResult> get copyWith => __$WhatsAppAddResultCopyWithImpl<_WhatsAppAddResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatsAppAddResult&&(identical(other.status, status) || other.status == status)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,status,validationError);

@override
String toString() {
  return 'WhatsAppAddResult(status: $status, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class _$WhatsAppAddResultCopyWith<$Res> implements $WhatsAppAddResultCopyWith<$Res> {
  factory _$WhatsAppAddResultCopyWith(_WhatsAppAddResult value, $Res Function(_WhatsAppAddResult) _then) = __$WhatsAppAddResultCopyWithImpl;
@override @useResult
$Res call({
 WhatsAppAddStatus status, String? validationError
});




}
/// @nodoc
class __$WhatsAppAddResultCopyWithImpl<$Res>
    implements _$WhatsAppAddResultCopyWith<$Res> {
  __$WhatsAppAddResultCopyWithImpl(this._self, this._then);

  final _WhatsAppAddResult _self;
  final $Res Function(_WhatsAppAddResult) _then;

/// Create a copy of WhatsAppAddResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? validationError = freezed,}) {
  return _then(_WhatsAppAddResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WhatsAppAddStatus,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
