// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whatsapp_pack.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WhatsAppPack {

 String get id; String get name; String get publisher; String get trayFileName; Uint8List get trayBytes; List<WhatsAppSticker> get stickers; bool get animated; int get version;
/// Create a copy of WhatsAppPack
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatsAppPackCopyWith<WhatsAppPack> get copyWith => _$WhatsAppPackCopyWithImpl<WhatsAppPack>(this as WhatsAppPack, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatsAppPack&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.trayFileName, trayFileName) || other.trayFileName == trayFileName)&&const DeepCollectionEquality().equals(other.trayBytes, trayBytes)&&const DeepCollectionEquality().equals(other.stickers, stickers)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,trayFileName,const DeepCollectionEquality().hash(trayBytes),const DeepCollectionEquality().hash(stickers),animated,version);

@override
String toString() {
  return 'WhatsAppPack(id: $id, name: $name, publisher: $publisher, trayFileName: $trayFileName, trayBytes: $trayBytes, stickers: $stickers, animated: $animated, version: $version)';
}


}

/// @nodoc
abstract mixin class $WhatsAppPackCopyWith<$Res>  {
  factory $WhatsAppPackCopyWith(WhatsAppPack value, $Res Function(WhatsAppPack) _then) = _$WhatsAppPackCopyWithImpl;
@useResult
$Res call({
 String id, String name, String publisher, String trayFileName, Uint8List trayBytes, List<WhatsAppSticker> stickers, bool animated, int version
});




}
/// @nodoc
class _$WhatsAppPackCopyWithImpl<$Res>
    implements $WhatsAppPackCopyWith<$Res> {
  _$WhatsAppPackCopyWithImpl(this._self, this._then);

  final WhatsAppPack _self;
  final $Res Function(WhatsAppPack) _then;

/// Create a copy of WhatsAppPack
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? trayFileName = null,Object? trayBytes = null,Object? stickers = null,Object? animated = null,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,trayFileName: null == trayFileName ? _self.trayFileName : trayFileName // ignore: cast_nullable_to_non_nullable
as String,trayBytes: null == trayBytes ? _self.trayBytes : trayBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,stickers: null == stickers ? _self.stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<WhatsAppSticker>,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WhatsAppPack].
extension WhatsAppPackPatterns on WhatsAppPack {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatsAppPack value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatsAppPack() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatsAppPack value)  $default,){
final _that = this;
switch (_that) {
case _WhatsAppPack():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatsAppPack value)?  $default,){
final _that = this;
switch (_that) {
case _WhatsAppPack() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  String trayFileName,  Uint8List trayBytes,  List<WhatsAppSticker> stickers,  bool animated,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatsAppPack() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.trayFileName,_that.trayBytes,_that.stickers,_that.animated,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  String trayFileName,  Uint8List trayBytes,  List<WhatsAppSticker> stickers,  bool animated,  int version)  $default,) {final _that = this;
switch (_that) {
case _WhatsAppPack():
return $default(_that.id,_that.name,_that.publisher,_that.trayFileName,_that.trayBytes,_that.stickers,_that.animated,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String publisher,  String trayFileName,  Uint8List trayBytes,  List<WhatsAppSticker> stickers,  bool animated,  int version)?  $default,) {final _that = this;
switch (_that) {
case _WhatsAppPack() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.trayFileName,_that.trayBytes,_that.stickers,_that.animated,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _WhatsAppPack implements WhatsAppPack {
  const _WhatsAppPack({required this.id, required this.name, required this.publisher, required this.trayFileName, required this.trayBytes, required  List<WhatsAppSticker> stickers, this.animated = false, this.version = 1}): _stickers = stickers;
  

@override final  String id;
@override final  String name;
@override final  String publisher;
@override final  String trayFileName;
@override final  Uint8List trayBytes;
 final  List<WhatsAppSticker> _stickers;
@override List<WhatsAppSticker> get stickers {
  if (_stickers is EqualUnmodifiableListView) return _stickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stickers);
}

@override@JsonKey() final  bool animated;
@override@JsonKey() final  int version;

/// Create a copy of WhatsAppPack
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatsAppPackCopyWith<_WhatsAppPack> get copyWith => __$WhatsAppPackCopyWithImpl<_WhatsAppPack>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatsAppPack&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.trayFileName, trayFileName) || other.trayFileName == trayFileName)&&const DeepCollectionEquality().equals(other.trayBytes, trayBytes)&&const DeepCollectionEquality().equals(other._stickers, _stickers)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,trayFileName,const DeepCollectionEquality().hash(trayBytes),const DeepCollectionEquality().hash(_stickers),animated,version);

@override
String toString() {
  return 'WhatsAppPack(id: $id, name: $name, publisher: $publisher, trayFileName: $trayFileName, trayBytes: $trayBytes, stickers: $stickers, animated: $animated, version: $version)';
}


}

/// @nodoc
abstract mixin class _$WhatsAppPackCopyWith<$Res> implements $WhatsAppPackCopyWith<$Res> {
  factory _$WhatsAppPackCopyWith(_WhatsAppPack value, $Res Function(_WhatsAppPack) _then) = __$WhatsAppPackCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String publisher, String trayFileName, Uint8List trayBytes, List<WhatsAppSticker> stickers, bool animated, int version
});




}
/// @nodoc
class __$WhatsAppPackCopyWithImpl<$Res>
    implements _$WhatsAppPackCopyWith<$Res> {
  __$WhatsAppPackCopyWithImpl(this._self, this._then);

  final _WhatsAppPack _self;
  final $Res Function(_WhatsAppPack) _then;

/// Create a copy of WhatsAppPack
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? trayFileName = null,Object? trayBytes = null,Object? stickers = null,Object? animated = null,Object? version = null,}) {
  return _then(_WhatsAppPack(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,trayFileName: null == trayFileName ? _self.trayFileName : trayFileName // ignore: cast_nullable_to_non_nullable
as String,trayBytes: null == trayBytes ? _self.trayBytes : trayBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,stickers: null == stickers ? _self._stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<WhatsAppSticker>,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
