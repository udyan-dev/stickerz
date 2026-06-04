// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whatsapp_sticker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WhatsAppSticker {

 String get fileName; Uint8List get bytes; List<String> get emojis; String get accessibilityText;
/// Create a copy of WhatsAppSticker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatsAppStickerCopyWith<WhatsAppSticker> get copyWith => _$WhatsAppStickerCopyWithImpl<WhatsAppSticker>(this as WhatsAppSticker, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatsAppSticker&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.accessibilityText, accessibilityText) || other.accessibilityText == accessibilityText));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(emojis),accessibilityText);

@override
String toString() {
  return 'WhatsAppSticker(fileName: $fileName, bytes: $bytes, emojis: $emojis, accessibilityText: $accessibilityText)';
}


}

/// @nodoc
abstract mixin class $WhatsAppStickerCopyWith<$Res>  {
  factory $WhatsAppStickerCopyWith(WhatsAppSticker value, $Res Function(WhatsAppSticker) _then) = _$WhatsAppStickerCopyWithImpl;
@useResult
$Res call({
 String fileName, Uint8List bytes, List<String> emojis, String accessibilityText
});




}
/// @nodoc
class _$WhatsAppStickerCopyWithImpl<$Res>
    implements $WhatsAppStickerCopyWith<$Res> {
  _$WhatsAppStickerCopyWithImpl(this._self, this._then);

  final WhatsAppSticker _self;
  final $Res Function(WhatsAppSticker) _then;

/// Create a copy of WhatsAppSticker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? bytes = null,Object? emojis = null,Object? accessibilityText = null,}) {
  return _then(_self.copyWith(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<String>,accessibilityText: null == accessibilityText ? _self.accessibilityText : accessibilityText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WhatsAppSticker].
extension WhatsAppStickerPatterns on WhatsAppSticker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatsAppSticker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatsAppSticker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatsAppSticker value)  $default,){
final _that = this;
switch (_that) {
case _WhatsAppSticker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatsAppSticker value)?  $default,){
final _that = this;
switch (_that) {
case _WhatsAppSticker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  Uint8List bytes,  List<String> emojis,  String accessibilityText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatsAppSticker() when $default != null:
return $default(_that.fileName,_that.bytes,_that.emojis,_that.accessibilityText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  Uint8List bytes,  List<String> emojis,  String accessibilityText)  $default,) {final _that = this;
switch (_that) {
case _WhatsAppSticker():
return $default(_that.fileName,_that.bytes,_that.emojis,_that.accessibilityText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  Uint8List bytes,  List<String> emojis,  String accessibilityText)?  $default,) {final _that = this;
switch (_that) {
case _WhatsAppSticker() when $default != null:
return $default(_that.fileName,_that.bytes,_that.emojis,_that.accessibilityText);case _:
  return null;

}
}

}

/// @nodoc


class _WhatsAppSticker implements WhatsAppSticker {
  const _WhatsAppSticker({required this.fileName, required this.bytes,  List<String> emojis = const <String>[], this.accessibilityText = ''}): _emojis = emojis;
  

@override final  String fileName;
@override final  Uint8List bytes;
 final  List<String> _emojis;
@override@JsonKey() List<String> get emojis {
  if (_emojis is EqualUnmodifiableListView) return _emojis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emojis);
}

@override@JsonKey() final  String accessibilityText;

/// Create a copy of WhatsAppSticker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatsAppStickerCopyWith<_WhatsAppSticker> get copyWith => __$WhatsAppStickerCopyWithImpl<_WhatsAppSticker>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatsAppSticker&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other._emojis, _emojis)&&(identical(other.accessibilityText, accessibilityText) || other.accessibilityText == accessibilityText));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(_emojis),accessibilityText);

@override
String toString() {
  return 'WhatsAppSticker(fileName: $fileName, bytes: $bytes, emojis: $emojis, accessibilityText: $accessibilityText)';
}


}

/// @nodoc
abstract mixin class _$WhatsAppStickerCopyWith<$Res> implements $WhatsAppStickerCopyWith<$Res> {
  factory _$WhatsAppStickerCopyWith(_WhatsAppSticker value, $Res Function(_WhatsAppSticker) _then) = __$WhatsAppStickerCopyWithImpl;
@override @useResult
$Res call({
 String fileName, Uint8List bytes, List<String> emojis, String accessibilityText
});




}
/// @nodoc
class __$WhatsAppStickerCopyWithImpl<$Res>
    implements _$WhatsAppStickerCopyWith<$Res> {
  __$WhatsAppStickerCopyWithImpl(this._self, this._then);

  final _WhatsAppSticker _self;
  final $Res Function(_WhatsAppSticker) _then;

/// Create a copy of WhatsAppSticker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? bytes = null,Object? emojis = null,Object? accessibilityText = null,}) {
  return _then(_WhatsAppSticker(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,emojis: null == emojis ? _self._emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<String>,accessibilityText: null == accessibilityText ? _self.accessibilityText : accessibilityText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
