// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pack_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StickerItem {

 String get file; List<String> get emojis; String get accessibilityText;
/// Create a copy of StickerItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StickerItemCopyWith<StickerItem> get copyWith => _$StickerItemCopyWithImpl<StickerItem>(this as StickerItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StickerItem&&(identical(other.file, file) || other.file == file)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.accessibilityText, accessibilityText) || other.accessibilityText == accessibilityText));
}


@override
int get hashCode => Object.hash(runtimeType,file,const DeepCollectionEquality().hash(emojis),accessibilityText);

@override
String toString() {
  return 'StickerItem(file: $file, emojis: $emojis, accessibilityText: $accessibilityText)';
}


}

/// @nodoc
abstract mixin class $StickerItemCopyWith<$Res>  {
  factory $StickerItemCopyWith(StickerItem value, $Res Function(StickerItem) _then) = _$StickerItemCopyWithImpl;
@useResult
$Res call({
 String file, List<String> emojis, String accessibilityText
});




}
/// @nodoc
class _$StickerItemCopyWithImpl<$Res>
    implements $StickerItemCopyWith<$Res> {
  _$StickerItemCopyWithImpl(this._self, this._then);

  final StickerItem _self;
  final $Res Function(StickerItem) _then;

/// Create a copy of StickerItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,Object? emojis = null,Object? accessibilityText = null,}) {
  return _then(_self.copyWith(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<String>,accessibilityText: null == accessibilityText ? _self.accessibilityText : accessibilityText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StickerItem].
extension StickerItemPatterns on StickerItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StickerItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StickerItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StickerItem value)  $default,){
final _that = this;
switch (_that) {
case _StickerItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StickerItem value)?  $default,){
final _that = this;
switch (_that) {
case _StickerItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String file,  List<String> emojis,  String accessibilityText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StickerItem() when $default != null:
return $default(_that.file,_that.emojis,_that.accessibilityText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String file,  List<String> emojis,  String accessibilityText)  $default,) {final _that = this;
switch (_that) {
case _StickerItem():
return $default(_that.file,_that.emojis,_that.accessibilityText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String file,  List<String> emojis,  String accessibilityText)?  $default,) {final _that = this;
switch (_that) {
case _StickerItem() when $default != null:
return $default(_that.file,_that.emojis,_that.accessibilityText);case _:
  return null;

}
}

}

/// @nodoc


class _StickerItem extends StickerItem {
  const _StickerItem({required this.file,  List<String> emojis = const <String>[], this.accessibilityText = ''}): _emojis = emojis,super._();
  

@override final  String file;
 final  List<String> _emojis;
@override@JsonKey() List<String> get emojis {
  if (_emojis is EqualUnmodifiableListView) return _emojis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emojis);
}

@override@JsonKey() final  String accessibilityText;

/// Create a copy of StickerItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StickerItemCopyWith<_StickerItem> get copyWith => __$StickerItemCopyWithImpl<_StickerItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StickerItem&&(identical(other.file, file) || other.file == file)&&const DeepCollectionEquality().equals(other._emojis, _emojis)&&(identical(other.accessibilityText, accessibilityText) || other.accessibilityText == accessibilityText));
}


@override
int get hashCode => Object.hash(runtimeType,file,const DeepCollectionEquality().hash(_emojis),accessibilityText);

@override
String toString() {
  return 'StickerItem(file: $file, emojis: $emojis, accessibilityText: $accessibilityText)';
}


}

/// @nodoc
abstract mixin class _$StickerItemCopyWith<$Res> implements $StickerItemCopyWith<$Res> {
  factory _$StickerItemCopyWith(_StickerItem value, $Res Function(_StickerItem) _then) = __$StickerItemCopyWithImpl;
@override @useResult
$Res call({
 String file, List<String> emojis, String accessibilityText
});




}
/// @nodoc
class __$StickerItemCopyWithImpl<$Res>
    implements _$StickerItemCopyWith<$Res> {
  __$StickerItemCopyWithImpl(this._self, this._then);

  final _StickerItem _self;
  final $Res Function(_StickerItem) _then;

/// Create a copy of StickerItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? emojis = null,Object? accessibilityText = null,}) {
  return _then(_StickerItem(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,emojis: null == emojis ? _self._emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<String>,accessibilityText: null == accessibilityText ? _self.accessibilityText : accessibilityText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PackManifest {

 String get id; String get name; String get publisher; bool get animated; String get tray; PackSource get source; String? get remoteId; int get version; List<StickerItem> get stickers;
/// Create a copy of PackManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PackManifestCopyWith<PackManifest> get copyWith => _$PackManifestCopyWithImpl<PackManifest>(this as PackManifest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PackManifest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.tray, tray) || other.tray == tray)&&(identical(other.source, source) || other.source == source)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.stickers, stickers));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,animated,tray,source,remoteId,version,const DeepCollectionEquality().hash(stickers));

@override
String toString() {
  return 'PackManifest(id: $id, name: $name, publisher: $publisher, animated: $animated, tray: $tray, source: $source, remoteId: $remoteId, version: $version, stickers: $stickers)';
}


}

/// @nodoc
abstract mixin class $PackManifestCopyWith<$Res>  {
  factory $PackManifestCopyWith(PackManifest value, $Res Function(PackManifest) _then) = _$PackManifestCopyWithImpl;
@useResult
$Res call({
 String id, String name, String publisher, bool animated, String tray, PackSource source, String? remoteId, int version, List<StickerItem> stickers
});




}
/// @nodoc
class _$PackManifestCopyWithImpl<$Res>
    implements $PackManifestCopyWith<$Res> {
  _$PackManifestCopyWithImpl(this._self, this._then);

  final PackManifest _self;
  final $Res Function(PackManifest) _then;

/// Create a copy of PackManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? animated = null,Object? tray = null,Object? source = null,Object? remoteId = freezed,Object? version = null,Object? stickers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tray: null == tray ? _self.tray : tray // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PackSource,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,stickers: null == stickers ? _self.stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<StickerItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PackManifest].
extension PackManifestPatterns on PackManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PackManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PackManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PackManifest value)  $default,){
final _that = this;
switch (_that) {
case _PackManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PackManifest value)?  $default,){
final _that = this;
switch (_that) {
case _PackManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PackManifest() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers)  $default,) {final _that = this;
switch (_that) {
case _PackManifest():
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers)?  $default,) {final _that = this;
switch (_that) {
case _PackManifest() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers);case _:
  return null;

}
}

}

/// @nodoc


class _PackManifest extends PackManifest {
  const _PackManifest({required this.id, required this.name, required this.publisher, this.animated = false, required this.tray, required this.source, this.remoteId, this.version = 1,  List<StickerItem> stickers = const <StickerItem>[]}): _stickers = stickers,super._();
  

@override final  String id;
@override final  String name;
@override final  String publisher;
@override@JsonKey() final  bool animated;
@override final  String tray;
@override final  PackSource source;
@override final  String? remoteId;
@override@JsonKey() final  int version;
 final  List<StickerItem> _stickers;
@override@JsonKey() List<StickerItem> get stickers {
  if (_stickers is EqualUnmodifiableListView) return _stickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stickers);
}


/// Create a copy of PackManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PackManifestCopyWith<_PackManifest> get copyWith => __$PackManifestCopyWithImpl<_PackManifest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PackManifest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.tray, tray) || other.tray == tray)&&(identical(other.source, source) || other.source == source)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._stickers, _stickers));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,animated,tray,source,remoteId,version,const DeepCollectionEquality().hash(_stickers));

@override
String toString() {
  return 'PackManifest(id: $id, name: $name, publisher: $publisher, animated: $animated, tray: $tray, source: $source, remoteId: $remoteId, version: $version, stickers: $stickers)';
}


}

/// @nodoc
abstract mixin class _$PackManifestCopyWith<$Res> implements $PackManifestCopyWith<$Res> {
  factory _$PackManifestCopyWith(_PackManifest value, $Res Function(_PackManifest) _then) = __$PackManifestCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String publisher, bool animated, String tray, PackSource source, String? remoteId, int version, List<StickerItem> stickers
});




}
/// @nodoc
class __$PackManifestCopyWithImpl<$Res>
    implements _$PackManifestCopyWith<$Res> {
  __$PackManifestCopyWithImpl(this._self, this._then);

  final _PackManifest _self;
  final $Res Function(_PackManifest) _then;

/// Create a copy of PackManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? animated = null,Object? tray = null,Object? source = null,Object? remoteId = freezed,Object? version = null,Object? stickers = null,}) {
  return _then(_PackManifest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tray: null == tray ? _self.tray : tray // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PackSource,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,stickers: null == stickers ? _self._stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<StickerItem>,
  ));
}


}

/// @nodoc
mixin _$StickerPack {

 String get id; String get name; String get publisher; bool get animated; String get tray; PackSource get source; String? get remoteId; int get version; List<StickerItem> get stickers; String get folderPath;
/// Create a copy of StickerPack
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StickerPackCopyWith<StickerPack> get copyWith => _$StickerPackCopyWithImpl<StickerPack>(this as StickerPack, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StickerPack&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.tray, tray) || other.tray == tray)&&(identical(other.source, source) || other.source == source)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.stickers, stickers)&&(identical(other.folderPath, folderPath) || other.folderPath == folderPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,animated,tray,source,remoteId,version,const DeepCollectionEquality().hash(stickers),folderPath);

@override
String toString() {
  return 'StickerPack(id: $id, name: $name, publisher: $publisher, animated: $animated, tray: $tray, source: $source, remoteId: $remoteId, version: $version, stickers: $stickers, folderPath: $folderPath)';
}


}

/// @nodoc
abstract mixin class $StickerPackCopyWith<$Res>  {
  factory $StickerPackCopyWith(StickerPack value, $Res Function(StickerPack) _then) = _$StickerPackCopyWithImpl;
@useResult
$Res call({
 String id, String name, String publisher, bool animated, String tray, PackSource source, String? remoteId, int version, List<StickerItem> stickers, String folderPath
});




}
/// @nodoc
class _$StickerPackCopyWithImpl<$Res>
    implements $StickerPackCopyWith<$Res> {
  _$StickerPackCopyWithImpl(this._self, this._then);

  final StickerPack _self;
  final $Res Function(StickerPack) _then;

/// Create a copy of StickerPack
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? animated = null,Object? tray = null,Object? source = null,Object? remoteId = freezed,Object? version = null,Object? stickers = null,Object? folderPath = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tray: null == tray ? _self.tray : tray // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PackSource,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,stickers: null == stickers ? _self.stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<StickerItem>,folderPath: null == folderPath ? _self.folderPath : folderPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StickerPack].
extension StickerPackPatterns on StickerPack {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StickerPack value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StickerPack() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StickerPack value)  $default,){
final _that = this;
switch (_that) {
case _StickerPack():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StickerPack value)?  $default,){
final _that = this;
switch (_that) {
case _StickerPack() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers,  String folderPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StickerPack() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers,_that.folderPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers,  String folderPath)  $default,) {final _that = this;
switch (_that) {
case _StickerPack():
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers,_that.folderPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String publisher,  bool animated,  String tray,  PackSource source,  String? remoteId,  int version,  List<StickerItem> stickers,  String folderPath)?  $default,) {final _that = this;
switch (_that) {
case _StickerPack() when $default != null:
return $default(_that.id,_that.name,_that.publisher,_that.animated,_that.tray,_that.source,_that.remoteId,_that.version,_that.stickers,_that.folderPath);case _:
  return null;

}
}

}

/// @nodoc


class _StickerPack extends StickerPack {
  const _StickerPack({required this.id, required this.name, required this.publisher, this.animated = false, required this.tray, required this.source, this.remoteId, this.version = 1,  List<StickerItem> stickers = const <StickerItem>[], required this.folderPath}): _stickers = stickers,super._();
  

@override final  String id;
@override final  String name;
@override final  String publisher;
@override@JsonKey() final  bool animated;
@override final  String tray;
@override final  PackSource source;
@override final  String? remoteId;
@override@JsonKey() final  int version;
 final  List<StickerItem> _stickers;
@override@JsonKey() List<StickerItem> get stickers {
  if (_stickers is EqualUnmodifiableListView) return _stickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stickers);
}

@override final  String folderPath;

/// Create a copy of StickerPack
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StickerPackCopyWith<_StickerPack> get copyWith => __$StickerPackCopyWithImpl<_StickerPack>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StickerPack&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.tray, tray) || other.tray == tray)&&(identical(other.source, source) || other.source == source)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._stickers, _stickers)&&(identical(other.folderPath, folderPath) || other.folderPath == folderPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,publisher,animated,tray,source,remoteId,version,const DeepCollectionEquality().hash(_stickers),folderPath);

@override
String toString() {
  return 'StickerPack(id: $id, name: $name, publisher: $publisher, animated: $animated, tray: $tray, source: $source, remoteId: $remoteId, version: $version, stickers: $stickers, folderPath: $folderPath)';
}


}

/// @nodoc
abstract mixin class _$StickerPackCopyWith<$Res> implements $StickerPackCopyWith<$Res> {
  factory _$StickerPackCopyWith(_StickerPack value, $Res Function(_StickerPack) _then) = __$StickerPackCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String publisher, bool animated, String tray, PackSource source, String? remoteId, int version, List<StickerItem> stickers, String folderPath
});




}
/// @nodoc
class __$StickerPackCopyWithImpl<$Res>
    implements _$StickerPackCopyWith<$Res> {
  __$StickerPackCopyWithImpl(this._self, this._then);

  final _StickerPack _self;
  final $Res Function(_StickerPack) _then;

/// Create a copy of StickerPack
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? publisher = null,Object? animated = null,Object? tray = null,Object? source = null,Object? remoteId = freezed,Object? version = null,Object? stickers = null,Object? folderPath = null,}) {
  return _then(_StickerPack(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tray: null == tray ? _self.tray : tray // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PackSource,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,stickers: null == stickers ? _self._stickers : stickers // ignore: cast_nullable_to_non_nullable
as List<StickerItem>,folderPath: null == folderPath ? _self.folderPath : folderPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
