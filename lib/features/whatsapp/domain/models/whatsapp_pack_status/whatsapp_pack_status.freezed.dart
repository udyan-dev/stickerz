// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whatsapp_pack_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WhatsAppPackStatus {

 List<WhatsAppTarget> get installed; List<WhatsAppTarget> get whitelisted;
/// Create a copy of WhatsAppPackStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatsAppPackStatusCopyWith<WhatsAppPackStatus> get copyWith => _$WhatsAppPackStatusCopyWithImpl<WhatsAppPackStatus>(this as WhatsAppPackStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatsAppPackStatus&&const DeepCollectionEquality().equals(other.installed, installed)&&const DeepCollectionEquality().equals(other.whitelisted, whitelisted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(installed),const DeepCollectionEquality().hash(whitelisted));

@override
String toString() {
  return 'WhatsAppPackStatus(installed: $installed, whitelisted: $whitelisted)';
}


}

/// @nodoc
abstract mixin class $WhatsAppPackStatusCopyWith<$Res>  {
  factory $WhatsAppPackStatusCopyWith(WhatsAppPackStatus value, $Res Function(WhatsAppPackStatus) _then) = _$WhatsAppPackStatusCopyWithImpl;
@useResult
$Res call({
 List<WhatsAppTarget> installed, List<WhatsAppTarget> whitelisted
});




}
/// @nodoc
class _$WhatsAppPackStatusCopyWithImpl<$Res>
    implements $WhatsAppPackStatusCopyWith<$Res> {
  _$WhatsAppPackStatusCopyWithImpl(this._self, this._then);

  final WhatsAppPackStatus _self;
  final $Res Function(WhatsAppPackStatus) _then;

/// Create a copy of WhatsAppPackStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? installed = null,Object? whitelisted = null,}) {
  return _then(_self.copyWith(
installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as List<WhatsAppTarget>,whitelisted: null == whitelisted ? _self.whitelisted : whitelisted // ignore: cast_nullable_to_non_nullable
as List<WhatsAppTarget>,
  ));
}

}


/// Adds pattern-matching-related methods to [WhatsAppPackStatus].
extension WhatsAppPackStatusPatterns on WhatsAppPackStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatsAppPackStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatsAppPackStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatsAppPackStatus value)  $default,){
final _that = this;
switch (_that) {
case _WhatsAppPackStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatsAppPackStatus value)?  $default,){
final _that = this;
switch (_that) {
case _WhatsAppPackStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WhatsAppTarget> installed,  List<WhatsAppTarget> whitelisted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatsAppPackStatus() when $default != null:
return $default(_that.installed,_that.whitelisted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WhatsAppTarget> installed,  List<WhatsAppTarget> whitelisted)  $default,) {final _that = this;
switch (_that) {
case _WhatsAppPackStatus():
return $default(_that.installed,_that.whitelisted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WhatsAppTarget> installed,  List<WhatsAppTarget> whitelisted)?  $default,) {final _that = this;
switch (_that) {
case _WhatsAppPackStatus() when $default != null:
return $default(_that.installed,_that.whitelisted);case _:
  return null;

}
}

}

/// @nodoc


class _WhatsAppPackStatus implements WhatsAppPackStatus {
  const _WhatsAppPackStatus({ List<WhatsAppTarget> installed = const <WhatsAppTarget>[],  List<WhatsAppTarget> whitelisted = const <WhatsAppTarget>[]}): _installed = installed,_whitelisted = whitelisted;
  

 final  List<WhatsAppTarget> _installed;
@override@JsonKey() List<WhatsAppTarget> get installed {
  if (_installed is EqualUnmodifiableListView) return _installed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installed);
}

 final  List<WhatsAppTarget> _whitelisted;
@override@JsonKey() List<WhatsAppTarget> get whitelisted {
  if (_whitelisted is EqualUnmodifiableListView) return _whitelisted;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_whitelisted);
}


/// Create a copy of WhatsAppPackStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatsAppPackStatusCopyWith<_WhatsAppPackStatus> get copyWith => __$WhatsAppPackStatusCopyWithImpl<_WhatsAppPackStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatsAppPackStatus&&const DeepCollectionEquality().equals(other._installed, _installed)&&const DeepCollectionEquality().equals(other._whitelisted, _whitelisted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_installed),const DeepCollectionEquality().hash(_whitelisted));

@override
String toString() {
  return 'WhatsAppPackStatus(installed: $installed, whitelisted: $whitelisted)';
}


}

/// @nodoc
abstract mixin class _$WhatsAppPackStatusCopyWith<$Res> implements $WhatsAppPackStatusCopyWith<$Res> {
  factory _$WhatsAppPackStatusCopyWith(_WhatsAppPackStatus value, $Res Function(_WhatsAppPackStatus) _then) = __$WhatsAppPackStatusCopyWithImpl;
@override @useResult
$Res call({
 List<WhatsAppTarget> installed, List<WhatsAppTarget> whitelisted
});




}
/// @nodoc
class __$WhatsAppPackStatusCopyWithImpl<$Res>
    implements _$WhatsAppPackStatusCopyWith<$Res> {
  __$WhatsAppPackStatusCopyWithImpl(this._self, this._then);

  final _WhatsAppPackStatus _self;
  final $Res Function(_WhatsAppPackStatus) _then;

/// Create a copy of WhatsAppPackStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? installed = null,Object? whitelisted = null,}) {
  return _then(_WhatsAppPackStatus(
installed: null == installed ? _self._installed : installed // ignore: cast_nullable_to_non_nullable
as List<WhatsAppTarget>,whitelisted: null == whitelisted ? _self._whitelisted : whitelisted // ignore: cast_nullable_to_non_nullable
as List<WhatsAppTarget>,
  ));
}


}

// dart format on
