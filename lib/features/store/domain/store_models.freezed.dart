// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoreFailure {

 StoreFailureType get type; StoreOperationScope get scope; String get message; bool get retryable; String? get code; String? get packId; String? get fileId; List<String> get reasons;
/// Create a copy of StoreFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreFailureCopyWith<StoreFailure> get copyWith => _$StoreFailureCopyWithImpl<StoreFailure>(this as StoreFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.message, message) || other.message == message)&&(identical(other.retryable, retryable) || other.retryable == retryable)&&(identical(other.code, code) || other.code == code)&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&const DeepCollectionEquality().equals(other.reasons, reasons));
}


@override
int get hashCode => Object.hash(runtimeType,type,scope,message,retryable,code,packId,fileId,const DeepCollectionEquality().hash(reasons));

@override
String toString() {
  return 'StoreFailure(type: $type, scope: $scope, message: $message, retryable: $retryable, code: $code, packId: $packId, fileId: $fileId, reasons: $reasons)';
}


}

/// @nodoc
abstract mixin class $StoreFailureCopyWith<$Res>  {
  factory $StoreFailureCopyWith(StoreFailure value, $Res Function(StoreFailure) _then) = _$StoreFailureCopyWithImpl;
@useResult
$Res call({
 StoreFailureType type, StoreOperationScope scope, String message, bool retryable, String? code, String? packId, String? fileId, List<String> reasons
});




}
/// @nodoc
class _$StoreFailureCopyWithImpl<$Res>
    implements $StoreFailureCopyWith<$Res> {
  _$StoreFailureCopyWithImpl(this._self, this._then);

  final StoreFailure _self;
  final $Res Function(StoreFailure) _then;

/// Create a copy of StoreFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? scope = null,Object? message = null,Object? retryable = null,Object? code = freezed,Object? packId = freezed,Object? fileId = freezed,Object? reasons = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StoreFailureType,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StoreOperationScope,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,retryable: null == retryable ? _self.retryable : retryable // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,packId: freezed == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String?,fileId: freezed == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String?,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreFailure].
extension StoreFailurePatterns on StoreFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreFailure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreFailure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreFailure value)  $default,){
final _that = this;
switch (_that) {
case _StoreFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreFailure value)?  $default,){
final _that = this;
switch (_that) {
case _StoreFailure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoreFailureType type,  StoreOperationScope scope,  String message,  bool retryable,  String? code,  String? packId,  String? fileId,  List<String> reasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreFailure() when $default != null:
return $default(_that.type,_that.scope,_that.message,_that.retryable,_that.code,_that.packId,_that.fileId,_that.reasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoreFailureType type,  StoreOperationScope scope,  String message,  bool retryable,  String? code,  String? packId,  String? fileId,  List<String> reasons)  $default,) {final _that = this;
switch (_that) {
case _StoreFailure():
return $default(_that.type,_that.scope,_that.message,_that.retryable,_that.code,_that.packId,_that.fileId,_that.reasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoreFailureType type,  StoreOperationScope scope,  String message,  bool retryable,  String? code,  String? packId,  String? fileId,  List<String> reasons)?  $default,) {final _that = this;
switch (_that) {
case _StoreFailure() when $default != null:
return $default(_that.type,_that.scope,_that.message,_that.retryable,_that.code,_that.packId,_that.fileId,_that.reasons);case _:
  return null;

}
}

}

/// @nodoc


class _StoreFailure implements StoreFailure {
  const _StoreFailure({required this.type, required this.scope, required this.message, this.retryable = false, this.code, this.packId, this.fileId,  List<String> reasons = const <String>[]}): _reasons = reasons;
  

@override final  StoreFailureType type;
@override final  StoreOperationScope scope;
@override final  String message;
@override@JsonKey() final  bool retryable;
@override final  String? code;
@override final  String? packId;
@override final  String? fileId;
 final  List<String> _reasons;
@override@JsonKey() List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}


/// Create a copy of StoreFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreFailureCopyWith<_StoreFailure> get copyWith => __$StoreFailureCopyWithImpl<_StoreFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.message, message) || other.message == message)&&(identical(other.retryable, retryable) || other.retryable == retryable)&&(identical(other.code, code) || other.code == code)&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&const DeepCollectionEquality().equals(other._reasons, _reasons));
}


@override
int get hashCode => Object.hash(runtimeType,type,scope,message,retryable,code,packId,fileId,const DeepCollectionEquality().hash(_reasons));

@override
String toString() {
  return 'StoreFailure(type: $type, scope: $scope, message: $message, retryable: $retryable, code: $code, packId: $packId, fileId: $fileId, reasons: $reasons)';
}


}

/// @nodoc
abstract mixin class _$StoreFailureCopyWith<$Res> implements $StoreFailureCopyWith<$Res> {
  factory _$StoreFailureCopyWith(_StoreFailure value, $Res Function(_StoreFailure) _then) = __$StoreFailureCopyWithImpl;
@override @useResult
$Res call({
 StoreFailureType type, StoreOperationScope scope, String message, bool retryable, String? code, String? packId, String? fileId, List<String> reasons
});




}
/// @nodoc
class __$StoreFailureCopyWithImpl<$Res>
    implements _$StoreFailureCopyWith<$Res> {
  __$StoreFailureCopyWithImpl(this._self, this._then);

  final _StoreFailure _self;
  final $Res Function(_StoreFailure) _then;

/// Create a copy of StoreFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? scope = null,Object? message = null,Object? retryable = null,Object? code = freezed,Object? packId = freezed,Object? fileId = freezed,Object? reasons = null,}) {
  return _then(_StoreFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StoreFailureType,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as StoreOperationScope,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,retryable: null == retryable ? _self.retryable : retryable // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,packId: freezed == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String?,fileId: freezed == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String?,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$StoreCategory {

 String get id; String get name; int get order;
/// Create a copy of StoreCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCategoryCopyWith<StoreCategory> get copyWith => _$StoreCategoryCopyWithImpl<StoreCategory>(this as StoreCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order);

@override
String toString() {
  return 'StoreCategory(id: $id, name: $name, order: $order)';
}


}

/// @nodoc
abstract mixin class $StoreCategoryCopyWith<$Res>  {
  factory $StoreCategoryCopyWith(StoreCategory value, $Res Function(StoreCategory) _then) = _$StoreCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, int order
});




}
/// @nodoc
class _$StoreCategoryCopyWithImpl<$Res>
    implements $StoreCategoryCopyWith<$Res> {
  _$StoreCategoryCopyWithImpl(this._self, this._then);

  final StoreCategory _self;
  final $Res Function(StoreCategory) _then;

/// Create a copy of StoreCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreCategory].
extension StoreCategoryPatterns on StoreCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreCategory value)  $default,){
final _that = this;
switch (_that) {
case _StoreCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreCategory value)?  $default,){
final _that = this;
switch (_that) {
case _StoreCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreCategory() when $default != null:
return $default(_that.id,_that.name,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int order)  $default,) {final _that = this;
switch (_that) {
case _StoreCategory():
return $default(_that.id,_that.name,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int order)?  $default,) {final _that = this;
switch (_that) {
case _StoreCategory() when $default != null:
return $default(_that.id,_that.name,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _StoreCategory implements StoreCategory {
  const _StoreCategory({required this.id, required this.name, this.order = 0});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  int order;

/// Create a copy of StoreCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCategoryCopyWith<_StoreCategory> get copyWith => __$StoreCategoryCopyWithImpl<_StoreCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order);

@override
String toString() {
  return 'StoreCategory(id: $id, name: $name, order: $order)';
}


}

/// @nodoc
abstract mixin class _$StoreCategoryCopyWith<$Res> implements $StoreCategoryCopyWith<$Res> {
  factory _$StoreCategoryCopyWith(_StoreCategory value, $Res Function(_StoreCategory) _then) = __$StoreCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int order
});




}
/// @nodoc
class __$StoreCategoryCopyWithImpl<$Res>
    implements _$StoreCategoryCopyWith<$Res> {
  __$StoreCategoryCopyWithImpl(this._self, this._then);

  final _StoreCategory _self;
  final $Res Function(_StoreCategory) _then;

/// Create a copy of StoreCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,}) {
  return _then(_StoreCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StoreCatalogIssue {

 String? get packId; int? get packIndex; StoreFailureType get type; String get message;
/// Create a copy of StoreCatalogIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCatalogIssueCopyWith<StoreCatalogIssue> get copyWith => _$StoreCatalogIssueCopyWithImpl<StoreCatalogIssue>(this as StoreCatalogIssue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreCatalogIssue&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.packIndex, packIndex) || other.packIndex == packIndex)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,packId,packIndex,type,message);

@override
String toString() {
  return 'StoreCatalogIssue(packId: $packId, packIndex: $packIndex, type: $type, message: $message)';
}


}

/// @nodoc
abstract mixin class $StoreCatalogIssueCopyWith<$Res>  {
  factory $StoreCatalogIssueCopyWith(StoreCatalogIssue value, $Res Function(StoreCatalogIssue) _then) = _$StoreCatalogIssueCopyWithImpl;
@useResult
$Res call({
 String? packId, int? packIndex, StoreFailureType type, String message
});




}
/// @nodoc
class _$StoreCatalogIssueCopyWithImpl<$Res>
    implements $StoreCatalogIssueCopyWith<$Res> {
  _$StoreCatalogIssueCopyWithImpl(this._self, this._then);

  final StoreCatalogIssue _self;
  final $Res Function(StoreCatalogIssue) _then;

/// Create a copy of StoreCatalogIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packId = freezed,Object? packIndex = freezed,Object? type = null,Object? message = null,}) {
  return _then(_self.copyWith(
packId: freezed == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String?,packIndex: freezed == packIndex ? _self.packIndex : packIndex // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StoreFailureType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreCatalogIssue].
extension StoreCatalogIssuePatterns on StoreCatalogIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreCatalogIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreCatalogIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreCatalogIssue value)  $default,){
final _that = this;
switch (_that) {
case _StoreCatalogIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreCatalogIssue value)?  $default,){
final _that = this;
switch (_that) {
case _StoreCatalogIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? packId,  int? packIndex,  StoreFailureType type,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreCatalogIssue() when $default != null:
return $default(_that.packId,_that.packIndex,_that.type,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? packId,  int? packIndex,  StoreFailureType type,  String message)  $default,) {final _that = this;
switch (_that) {
case _StoreCatalogIssue():
return $default(_that.packId,_that.packIndex,_that.type,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? packId,  int? packIndex,  StoreFailureType type,  String message)?  $default,) {final _that = this;
switch (_that) {
case _StoreCatalogIssue() when $default != null:
return $default(_that.packId,_that.packIndex,_that.type,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _StoreCatalogIssue implements StoreCatalogIssue {
  const _StoreCatalogIssue({this.packId, this.packIndex, required this.type, required this.message});
  

@override final  String? packId;
@override final  int? packIndex;
@override final  StoreFailureType type;
@override final  String message;

/// Create a copy of StoreCatalogIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCatalogIssueCopyWith<_StoreCatalogIssue> get copyWith => __$StoreCatalogIssueCopyWithImpl<_StoreCatalogIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreCatalogIssue&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.packIndex, packIndex) || other.packIndex == packIndex)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,packId,packIndex,type,message);

@override
String toString() {
  return 'StoreCatalogIssue(packId: $packId, packIndex: $packIndex, type: $type, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StoreCatalogIssueCopyWith<$Res> implements $StoreCatalogIssueCopyWith<$Res> {
  factory _$StoreCatalogIssueCopyWith(_StoreCatalogIssue value, $Res Function(_StoreCatalogIssue) _then) = __$StoreCatalogIssueCopyWithImpl;
@override @useResult
$Res call({
 String? packId, int? packIndex, StoreFailureType type, String message
});




}
/// @nodoc
class __$StoreCatalogIssueCopyWithImpl<$Res>
    implements _$StoreCatalogIssueCopyWith<$Res> {
  __$StoreCatalogIssueCopyWithImpl(this._self, this._then);

  final _StoreCatalogIssue _self;
  final $Res Function(_StoreCatalogIssue) _then;

/// Create a copy of StoreCatalogIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packId = freezed,Object? packIndex = freezed,Object? type = null,Object? message = null,}) {
  return _then(_StoreCatalogIssue(
packId: freezed == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String?,packIndex: freezed == packIndex ? _self.packIndex : packIndex // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StoreFailureType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StoreRemoteFileInfo {

 String get fileId; String get name; String get mimeType; int get sizeBytes;
/// Create a copy of StoreRemoteFileInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreRemoteFileInfoCopyWith<StoreRemoteFileInfo> get copyWith => _$StoreRemoteFileInfoCopyWithImpl<StoreRemoteFileInfo>(this as StoreRemoteFileInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreRemoteFileInfo&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,fileId,name,mimeType,sizeBytes);

@override
String toString() {
  return 'StoreRemoteFileInfo(fileId: $fileId, name: $name, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $StoreRemoteFileInfoCopyWith<$Res>  {
  factory $StoreRemoteFileInfoCopyWith(StoreRemoteFileInfo value, $Res Function(StoreRemoteFileInfo) _then) = _$StoreRemoteFileInfoCopyWithImpl;
@useResult
$Res call({
 String fileId, String name, String mimeType, int sizeBytes
});




}
/// @nodoc
class _$StoreRemoteFileInfoCopyWithImpl<$Res>
    implements $StoreRemoteFileInfoCopyWith<$Res> {
  _$StoreRemoteFileInfoCopyWithImpl(this._self, this._then);

  final StoreRemoteFileInfo _self;
  final $Res Function(StoreRemoteFileInfo) _then;

/// Create a copy of StoreRemoteFileInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? name = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(_self.copyWith(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreRemoteFileInfo].
extension StoreRemoteFileInfoPatterns on StoreRemoteFileInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreRemoteFileInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreRemoteFileInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreRemoteFileInfo value)  $default,){
final _that = this;
switch (_that) {
case _StoreRemoteFileInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreRemoteFileInfo value)?  $default,){
final _that = this;
switch (_that) {
case _StoreRemoteFileInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  String name,  String mimeType,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreRemoteFileInfo() when $default != null:
return $default(_that.fileId,_that.name,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  String name,  String mimeType,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _StoreRemoteFileInfo():
return $default(_that.fileId,_that.name,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  String name,  String mimeType,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _StoreRemoteFileInfo() when $default != null:
return $default(_that.fileId,_that.name,_that.mimeType,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _StoreRemoteFileInfo implements StoreRemoteFileInfo {
  const _StoreRemoteFileInfo({required this.fileId, required this.name, required this.mimeType, required this.sizeBytes});
  

@override final  String fileId;
@override final  String name;
@override final  String mimeType;
@override final  int sizeBytes;

/// Create a copy of StoreRemoteFileInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreRemoteFileInfoCopyWith<_StoreRemoteFileInfo> get copyWith => __$StoreRemoteFileInfoCopyWithImpl<_StoreRemoteFileInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreRemoteFileInfo&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,fileId,name,mimeType,sizeBytes);

@override
String toString() {
  return 'StoreRemoteFileInfo(fileId: $fileId, name: $name, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$StoreRemoteFileInfoCopyWith<$Res> implements $StoreRemoteFileInfoCopyWith<$Res> {
  factory _$StoreRemoteFileInfoCopyWith(_StoreRemoteFileInfo value, $Res Function(_StoreRemoteFileInfo) _then) = __$StoreRemoteFileInfoCopyWithImpl;
@override @useResult
$Res call({
 String fileId, String name, String mimeType, int sizeBytes
});




}
/// @nodoc
class __$StoreRemoteFileInfoCopyWithImpl<$Res>
    implements _$StoreRemoteFileInfoCopyWith<$Res> {
  __$StoreRemoteFileInfoCopyWithImpl(this._self, this._then);

  final _StoreRemoteFileInfo _self;
  final $Res Function(_StoreRemoteFileInfo) _then;

/// Create a copy of StoreRemoteFileInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? name = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(_StoreRemoteFileInfo(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StoreRemotePack {

 String get id; int get version; String get name; String get publisher; String? get categoryId; bool get featured; String get trayFileId; List<String> get stickerFileIds; String? get thumbnailFileId; bool get animated; List<String> get tags; int get sizeBytes;
/// Create a copy of StoreRemotePack
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreRemotePackCopyWith<StoreRemotePack> get copyWith => _$StoreRemotePackCopyWithImpl<StoreRemotePack>(this as StoreRemotePack, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreRemotePack&&(identical(other.id, id) || other.id == id)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.trayFileId, trayFileId) || other.trayFileId == trayFileId)&&const DeepCollectionEquality().equals(other.stickerFileIds, stickerFileIds)&&(identical(other.thumbnailFileId, thumbnailFileId) || other.thumbnailFileId == thumbnailFileId)&&(identical(other.animated, animated) || other.animated == animated)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,id,version,name,publisher,categoryId,featured,trayFileId,const DeepCollectionEquality().hash(stickerFileIds),thumbnailFileId,animated,const DeepCollectionEquality().hash(tags),sizeBytes);

@override
String toString() {
  return 'StoreRemotePack(id: $id, version: $version, name: $name, publisher: $publisher, categoryId: $categoryId, featured: $featured, trayFileId: $trayFileId, stickerFileIds: $stickerFileIds, thumbnailFileId: $thumbnailFileId, animated: $animated, tags: $tags, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $StoreRemotePackCopyWith<$Res>  {
  factory $StoreRemotePackCopyWith(StoreRemotePack value, $Res Function(StoreRemotePack) _then) = _$StoreRemotePackCopyWithImpl;
@useResult
$Res call({
 String id, int version, String name, String publisher, String? categoryId, bool featured, String trayFileId, List<String> stickerFileIds, String? thumbnailFileId, bool animated, List<String> tags, int sizeBytes
});




}
/// @nodoc
class _$StoreRemotePackCopyWithImpl<$Res>
    implements $StoreRemotePackCopyWith<$Res> {
  _$StoreRemotePackCopyWithImpl(this._self, this._then);

  final StoreRemotePack _self;
  final $Res Function(StoreRemotePack) _then;

/// Create a copy of StoreRemotePack
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? version = null,Object? name = null,Object? publisher = null,Object? categoryId = freezed,Object? featured = null,Object? trayFileId = null,Object? stickerFileIds = null,Object? thumbnailFileId = freezed,Object? animated = null,Object? tags = null,Object? sizeBytes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,trayFileId: null == trayFileId ? _self.trayFileId : trayFileId // ignore: cast_nullable_to_non_nullable
as String,stickerFileIds: null == stickerFileIds ? _self.stickerFileIds : stickerFileIds // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailFileId: freezed == thumbnailFileId ? _self.thumbnailFileId : thumbnailFileId // ignore: cast_nullable_to_non_nullable
as String?,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreRemotePack].
extension StoreRemotePackPatterns on StoreRemotePack {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreRemotePack value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreRemotePack() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreRemotePack value)  $default,){
final _that = this;
switch (_that) {
case _StoreRemotePack():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreRemotePack value)?  $default,){
final _that = this;
switch (_that) {
case _StoreRemotePack() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int version,  String name,  String publisher,  String? categoryId,  bool featured,  String trayFileId,  List<String> stickerFileIds,  String? thumbnailFileId,  bool animated,  List<String> tags,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreRemotePack() when $default != null:
return $default(_that.id,_that.version,_that.name,_that.publisher,_that.categoryId,_that.featured,_that.trayFileId,_that.stickerFileIds,_that.thumbnailFileId,_that.animated,_that.tags,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int version,  String name,  String publisher,  String? categoryId,  bool featured,  String trayFileId,  List<String> stickerFileIds,  String? thumbnailFileId,  bool animated,  List<String> tags,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _StoreRemotePack():
return $default(_that.id,_that.version,_that.name,_that.publisher,_that.categoryId,_that.featured,_that.trayFileId,_that.stickerFileIds,_that.thumbnailFileId,_that.animated,_that.tags,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int version,  String name,  String publisher,  String? categoryId,  bool featured,  String trayFileId,  List<String> stickerFileIds,  String? thumbnailFileId,  bool animated,  List<String> tags,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _StoreRemotePack() when $default != null:
return $default(_that.id,_that.version,_that.name,_that.publisher,_that.categoryId,_that.featured,_that.trayFileId,_that.stickerFileIds,_that.thumbnailFileId,_that.animated,_that.tags,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _StoreRemotePack extends StoreRemotePack {
  const _StoreRemotePack({required this.id, required this.version, required this.name, required this.publisher, this.categoryId, this.featured = false, required this.trayFileId,  List<String> stickerFileIds = const <String>[], this.thumbnailFileId, this.animated = false,  List<String> tags = const <String>[], this.sizeBytes = 0}): _stickerFileIds = stickerFileIds,_tags = tags,super._();
  

@override final  String id;
@override final  int version;
@override final  String name;
@override final  String publisher;
@override final  String? categoryId;
@override@JsonKey() final  bool featured;
@override final  String trayFileId;
 final  List<String> _stickerFileIds;
@override@JsonKey() List<String> get stickerFileIds {
  if (_stickerFileIds is EqualUnmodifiableListView) return _stickerFileIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stickerFileIds);
}

@override final  String? thumbnailFileId;
@override@JsonKey() final  bool animated;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  int sizeBytes;

/// Create a copy of StoreRemotePack
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreRemotePackCopyWith<_StoreRemotePack> get copyWith => __$StoreRemotePackCopyWithImpl<_StoreRemotePack>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreRemotePack&&(identical(other.id, id) || other.id == id)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.trayFileId, trayFileId) || other.trayFileId == trayFileId)&&const DeepCollectionEquality().equals(other._stickerFileIds, _stickerFileIds)&&(identical(other.thumbnailFileId, thumbnailFileId) || other.thumbnailFileId == thumbnailFileId)&&(identical(other.animated, animated) || other.animated == animated)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,id,version,name,publisher,categoryId,featured,trayFileId,const DeepCollectionEquality().hash(_stickerFileIds),thumbnailFileId,animated,const DeepCollectionEquality().hash(_tags),sizeBytes);

@override
String toString() {
  return 'StoreRemotePack(id: $id, version: $version, name: $name, publisher: $publisher, categoryId: $categoryId, featured: $featured, trayFileId: $trayFileId, stickerFileIds: $stickerFileIds, thumbnailFileId: $thumbnailFileId, animated: $animated, tags: $tags, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$StoreRemotePackCopyWith<$Res> implements $StoreRemotePackCopyWith<$Res> {
  factory _$StoreRemotePackCopyWith(_StoreRemotePack value, $Res Function(_StoreRemotePack) _then) = __$StoreRemotePackCopyWithImpl;
@override @useResult
$Res call({
 String id, int version, String name, String publisher, String? categoryId, bool featured, String trayFileId, List<String> stickerFileIds, String? thumbnailFileId, bool animated, List<String> tags, int sizeBytes
});




}
/// @nodoc
class __$StoreRemotePackCopyWithImpl<$Res>
    implements _$StoreRemotePackCopyWith<$Res> {
  __$StoreRemotePackCopyWithImpl(this._self, this._then);

  final _StoreRemotePack _self;
  final $Res Function(_StoreRemotePack) _then;

/// Create a copy of StoreRemotePack
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? version = null,Object? name = null,Object? publisher = null,Object? categoryId = freezed,Object? featured = null,Object? trayFileId = null,Object? stickerFileIds = null,Object? thumbnailFileId = freezed,Object? animated = null,Object? tags = null,Object? sizeBytes = null,}) {
  return _then(_StoreRemotePack(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,trayFileId: null == trayFileId ? _self.trayFileId : trayFileId // ignore: cast_nullable_to_non_nullable
as String,stickerFileIds: null == stickerFileIds ? _self._stickerFileIds : stickerFileIds // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailFileId: freezed == thumbnailFileId ? _self.thumbnailFileId : thumbnailFileId // ignore: cast_nullable_to_non_nullable
as String?,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StoreCatalog {

 int get version; DateTime? get updatedAt; List<StoreCategory> get categories; List<StoreRemotePack> get packs; Map<String, StoreRemotePack> get packsById; List<String> get featuredPackIds; List<StoreCatalogIssue> get issues;
/// Create a copy of StoreCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCatalogCopyWith<StoreCatalog> get copyWith => _$StoreCatalogCopyWithImpl<StoreCatalog>(this as StoreCatalog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreCatalog&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.packs, packs)&&const DeepCollectionEquality().equals(other.packsById, packsById)&&const DeepCollectionEquality().equals(other.featuredPackIds, featuredPackIds)&&const DeepCollectionEquality().equals(other.issues, issues));
}


@override
int get hashCode => Object.hash(runtimeType,version,updatedAt,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(packs),const DeepCollectionEquality().hash(packsById),const DeepCollectionEquality().hash(featuredPackIds),const DeepCollectionEquality().hash(issues));

@override
String toString() {
  return 'StoreCatalog(version: $version, updatedAt: $updatedAt, categories: $categories, packs: $packs, packsById: $packsById, featuredPackIds: $featuredPackIds, issues: $issues)';
}


}

/// @nodoc
abstract mixin class $StoreCatalogCopyWith<$Res>  {
  factory $StoreCatalogCopyWith(StoreCatalog value, $Res Function(StoreCatalog) _then) = _$StoreCatalogCopyWithImpl;
@useResult
$Res call({
 int version, DateTime? updatedAt, List<StoreCategory> categories, List<StoreRemotePack> packs, Map<String, StoreRemotePack> packsById, List<String> featuredPackIds, List<StoreCatalogIssue> issues
});




}
/// @nodoc
class _$StoreCatalogCopyWithImpl<$Res>
    implements $StoreCatalogCopyWith<$Res> {
  _$StoreCatalogCopyWithImpl(this._self, this._then);

  final StoreCatalog _self;
  final $Res Function(StoreCatalog) _then;

/// Create a copy of StoreCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? updatedAt = freezed,Object? categories = null,Object? packs = null,Object? packsById = null,Object? featuredPackIds = null,Object? issues = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<StoreCategory>,packs: null == packs ? _self.packs : packs // ignore: cast_nullable_to_non_nullable
as List<StoreRemotePack>,packsById: null == packsById ? _self.packsById : packsById // ignore: cast_nullable_to_non_nullable
as Map<String, StoreRemotePack>,featuredPackIds: null == featuredPackIds ? _self.featuredPackIds : featuredPackIds // ignore: cast_nullable_to_non_nullable
as List<String>,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<StoreCatalogIssue>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreCatalog].
extension StoreCatalogPatterns on StoreCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreCatalog value)  $default,){
final _that = this;
switch (_that) {
case _StoreCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _StoreCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  DateTime? updatedAt,  List<StoreCategory> categories,  List<StoreRemotePack> packs,  Map<String, StoreRemotePack> packsById,  List<String> featuredPackIds,  List<StoreCatalogIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreCatalog() when $default != null:
return $default(_that.version,_that.updatedAt,_that.categories,_that.packs,_that.packsById,_that.featuredPackIds,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  DateTime? updatedAt,  List<StoreCategory> categories,  List<StoreRemotePack> packs,  Map<String, StoreRemotePack> packsById,  List<String> featuredPackIds,  List<StoreCatalogIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _StoreCatalog():
return $default(_that.version,_that.updatedAt,_that.categories,_that.packs,_that.packsById,_that.featuredPackIds,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  DateTime? updatedAt,  List<StoreCategory> categories,  List<StoreRemotePack> packs,  Map<String, StoreRemotePack> packsById,  List<String> featuredPackIds,  List<StoreCatalogIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _StoreCatalog() when $default != null:
return $default(_that.version,_that.updatedAt,_that.categories,_that.packs,_that.packsById,_that.featuredPackIds,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _StoreCatalog extends StoreCatalog {
  const _StoreCatalog({required this.version, this.updatedAt,  List<StoreCategory> categories = const <StoreCategory>[],  List<StoreRemotePack> packs = const <StoreRemotePack>[],  Map<String, StoreRemotePack> packsById = const <String, StoreRemotePack>{},  List<String> featuredPackIds = const <String>[],  List<StoreCatalogIssue> issues = const <StoreCatalogIssue>[]}): _categories = categories,_packs = packs,_packsById = packsById,_featuredPackIds = featuredPackIds,_issues = issues,super._();
  

@override final  int version;
@override final  DateTime? updatedAt;
 final  List<StoreCategory> _categories;
@override@JsonKey() List<StoreCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<StoreRemotePack> _packs;
@override@JsonKey() List<StoreRemotePack> get packs {
  if (_packs is EqualUnmodifiableListView) return _packs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packs);
}

 final  Map<String, StoreRemotePack> _packsById;
@override@JsonKey() Map<String, StoreRemotePack> get packsById {
  if (_packsById is EqualUnmodifiableMapView) return _packsById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_packsById);
}

 final  List<String> _featuredPackIds;
@override@JsonKey() List<String> get featuredPackIds {
  if (_featuredPackIds is EqualUnmodifiableListView) return _featuredPackIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredPackIds);
}

 final  List<StoreCatalogIssue> _issues;
@override@JsonKey() List<StoreCatalogIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of StoreCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCatalogCopyWith<_StoreCatalog> get copyWith => __$StoreCatalogCopyWithImpl<_StoreCatalog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreCatalog&&(identical(other.version, version) || other.version == version)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._packs, _packs)&&const DeepCollectionEquality().equals(other._packsById, _packsById)&&const DeepCollectionEquality().equals(other._featuredPackIds, _featuredPackIds)&&const DeepCollectionEquality().equals(other._issues, _issues));
}


@override
int get hashCode => Object.hash(runtimeType,version,updatedAt,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_packs),const DeepCollectionEquality().hash(_packsById),const DeepCollectionEquality().hash(_featuredPackIds),const DeepCollectionEquality().hash(_issues));

@override
String toString() {
  return 'StoreCatalog(version: $version, updatedAt: $updatedAt, categories: $categories, packs: $packs, packsById: $packsById, featuredPackIds: $featuredPackIds, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$StoreCatalogCopyWith<$Res> implements $StoreCatalogCopyWith<$Res> {
  factory _$StoreCatalogCopyWith(_StoreCatalog value, $Res Function(_StoreCatalog) _then) = __$StoreCatalogCopyWithImpl;
@override @useResult
$Res call({
 int version, DateTime? updatedAt, List<StoreCategory> categories, List<StoreRemotePack> packs, Map<String, StoreRemotePack> packsById, List<String> featuredPackIds, List<StoreCatalogIssue> issues
});




}
/// @nodoc
class __$StoreCatalogCopyWithImpl<$Res>
    implements _$StoreCatalogCopyWith<$Res> {
  __$StoreCatalogCopyWithImpl(this._self, this._then);

  final _StoreCatalog _self;
  final $Res Function(_StoreCatalog) _then;

/// Create a copy of StoreCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? updatedAt = freezed,Object? categories = null,Object? packs = null,Object? packsById = null,Object? featuredPackIds = null,Object? issues = null,}) {
  return _then(_StoreCatalog(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<StoreCategory>,packs: null == packs ? _self._packs : packs // ignore: cast_nullable_to_non_nullable
as List<StoreRemotePack>,packsById: null == packsById ? _self._packsById : packsById // ignore: cast_nullable_to_non_nullable
as Map<String, StoreRemotePack>,featuredPackIds: null == featuredPackIds ? _self._featuredPackIds : featuredPackIds // ignore: cast_nullable_to_non_nullable
as List<String>,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<StoreCatalogIssue>,
  ));
}


}

/// @nodoc
mixin _$StoreLocalPackStatus {

 String get remotePackId; String? get localPackId; int? get localVersion; bool get installed; bool get valid; bool get sameVersionInstalled; bool get updateAvailable; bool get repairAvailable;
/// Create a copy of StoreLocalPackStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreLocalPackStatusCopyWith<StoreLocalPackStatus> get copyWith => _$StoreLocalPackStatusCopyWithImpl<StoreLocalPackStatus>(this as StoreLocalPackStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreLocalPackStatus&&(identical(other.remotePackId, remotePackId) || other.remotePackId == remotePackId)&&(identical(other.localPackId, localPackId) || other.localPackId == localPackId)&&(identical(other.localVersion, localVersion) || other.localVersion == localVersion)&&(identical(other.installed, installed) || other.installed == installed)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.sameVersionInstalled, sameVersionInstalled) || other.sameVersionInstalled == sameVersionInstalled)&&(identical(other.updateAvailable, updateAvailable) || other.updateAvailable == updateAvailable)&&(identical(other.repairAvailable, repairAvailable) || other.repairAvailable == repairAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,remotePackId,localPackId,localVersion,installed,valid,sameVersionInstalled,updateAvailable,repairAvailable);

@override
String toString() {
  return 'StoreLocalPackStatus(remotePackId: $remotePackId, localPackId: $localPackId, localVersion: $localVersion, installed: $installed, valid: $valid, sameVersionInstalled: $sameVersionInstalled, updateAvailable: $updateAvailable, repairAvailable: $repairAvailable)';
}


}

/// @nodoc
abstract mixin class $StoreLocalPackStatusCopyWith<$Res>  {
  factory $StoreLocalPackStatusCopyWith(StoreLocalPackStatus value, $Res Function(StoreLocalPackStatus) _then) = _$StoreLocalPackStatusCopyWithImpl;
@useResult
$Res call({
 String remotePackId, String? localPackId, int? localVersion, bool installed, bool valid, bool sameVersionInstalled, bool updateAvailable, bool repairAvailable
});




}
/// @nodoc
class _$StoreLocalPackStatusCopyWithImpl<$Res>
    implements $StoreLocalPackStatusCopyWith<$Res> {
  _$StoreLocalPackStatusCopyWithImpl(this._self, this._then);

  final StoreLocalPackStatus _self;
  final $Res Function(StoreLocalPackStatus) _then;

/// Create a copy of StoreLocalPackStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remotePackId = null,Object? localPackId = freezed,Object? localVersion = freezed,Object? installed = null,Object? valid = null,Object? sameVersionInstalled = null,Object? updateAvailable = null,Object? repairAvailable = null,}) {
  return _then(_self.copyWith(
remotePackId: null == remotePackId ? _self.remotePackId : remotePackId // ignore: cast_nullable_to_non_nullable
as String,localPackId: freezed == localPackId ? _self.localPackId : localPackId // ignore: cast_nullable_to_non_nullable
as String?,localVersion: freezed == localVersion ? _self.localVersion : localVersion // ignore: cast_nullable_to_non_nullable
as int?,installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,sameVersionInstalled: null == sameVersionInstalled ? _self.sameVersionInstalled : sameVersionInstalled // ignore: cast_nullable_to_non_nullable
as bool,updateAvailable: null == updateAvailable ? _self.updateAvailable : updateAvailable // ignore: cast_nullable_to_non_nullable
as bool,repairAvailable: null == repairAvailable ? _self.repairAvailable : repairAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreLocalPackStatus].
extension StoreLocalPackStatusPatterns on StoreLocalPackStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreLocalPackStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreLocalPackStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreLocalPackStatus value)  $default,){
final _that = this;
switch (_that) {
case _StoreLocalPackStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreLocalPackStatus value)?  $default,){
final _that = this;
switch (_that) {
case _StoreLocalPackStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String remotePackId,  String? localPackId,  int? localVersion,  bool installed,  bool valid,  bool sameVersionInstalled,  bool updateAvailable,  bool repairAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreLocalPackStatus() when $default != null:
return $default(_that.remotePackId,_that.localPackId,_that.localVersion,_that.installed,_that.valid,_that.sameVersionInstalled,_that.updateAvailable,_that.repairAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String remotePackId,  String? localPackId,  int? localVersion,  bool installed,  bool valid,  bool sameVersionInstalled,  bool updateAvailable,  bool repairAvailable)  $default,) {final _that = this;
switch (_that) {
case _StoreLocalPackStatus():
return $default(_that.remotePackId,_that.localPackId,_that.localVersion,_that.installed,_that.valid,_that.sameVersionInstalled,_that.updateAvailable,_that.repairAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String remotePackId,  String? localPackId,  int? localVersion,  bool installed,  bool valid,  bool sameVersionInstalled,  bool updateAvailable,  bool repairAvailable)?  $default,) {final _that = this;
switch (_that) {
case _StoreLocalPackStatus() when $default != null:
return $default(_that.remotePackId,_that.localPackId,_that.localVersion,_that.installed,_that.valid,_that.sameVersionInstalled,_that.updateAvailable,_that.repairAvailable);case _:
  return null;

}
}

}

/// @nodoc


class _StoreLocalPackStatus extends StoreLocalPackStatus {
  const _StoreLocalPackStatus({required this.remotePackId, this.localPackId, this.localVersion, this.installed = false, this.valid = false, this.sameVersionInstalled = false, this.updateAvailable = false, this.repairAvailable = false}): super._();
  

@override final  String remotePackId;
@override final  String? localPackId;
@override final  int? localVersion;
@override@JsonKey() final  bool installed;
@override@JsonKey() final  bool valid;
@override@JsonKey() final  bool sameVersionInstalled;
@override@JsonKey() final  bool updateAvailable;
@override@JsonKey() final  bool repairAvailable;

/// Create a copy of StoreLocalPackStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreLocalPackStatusCopyWith<_StoreLocalPackStatus> get copyWith => __$StoreLocalPackStatusCopyWithImpl<_StoreLocalPackStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreLocalPackStatus&&(identical(other.remotePackId, remotePackId) || other.remotePackId == remotePackId)&&(identical(other.localPackId, localPackId) || other.localPackId == localPackId)&&(identical(other.localVersion, localVersion) || other.localVersion == localVersion)&&(identical(other.installed, installed) || other.installed == installed)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.sameVersionInstalled, sameVersionInstalled) || other.sameVersionInstalled == sameVersionInstalled)&&(identical(other.updateAvailable, updateAvailable) || other.updateAvailable == updateAvailable)&&(identical(other.repairAvailable, repairAvailable) || other.repairAvailable == repairAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,remotePackId,localPackId,localVersion,installed,valid,sameVersionInstalled,updateAvailable,repairAvailable);

@override
String toString() {
  return 'StoreLocalPackStatus(remotePackId: $remotePackId, localPackId: $localPackId, localVersion: $localVersion, installed: $installed, valid: $valid, sameVersionInstalled: $sameVersionInstalled, updateAvailable: $updateAvailable, repairAvailable: $repairAvailable)';
}


}

/// @nodoc
abstract mixin class _$StoreLocalPackStatusCopyWith<$Res> implements $StoreLocalPackStatusCopyWith<$Res> {
  factory _$StoreLocalPackStatusCopyWith(_StoreLocalPackStatus value, $Res Function(_StoreLocalPackStatus) _then) = __$StoreLocalPackStatusCopyWithImpl;
@override @useResult
$Res call({
 String remotePackId, String? localPackId, int? localVersion, bool installed, bool valid, bool sameVersionInstalled, bool updateAvailable, bool repairAvailable
});




}
/// @nodoc
class __$StoreLocalPackStatusCopyWithImpl<$Res>
    implements _$StoreLocalPackStatusCopyWith<$Res> {
  __$StoreLocalPackStatusCopyWithImpl(this._self, this._then);

  final _StoreLocalPackStatus _self;
  final $Res Function(_StoreLocalPackStatus) _then;

/// Create a copy of StoreLocalPackStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remotePackId = null,Object? localPackId = freezed,Object? localVersion = freezed,Object? installed = null,Object? valid = null,Object? sameVersionInstalled = null,Object? updateAvailable = null,Object? repairAvailable = null,}) {
  return _then(_StoreLocalPackStatus(
remotePackId: null == remotePackId ? _self.remotePackId : remotePackId // ignore: cast_nullable_to_non_nullable
as String,localPackId: freezed == localPackId ? _self.localPackId : localPackId // ignore: cast_nullable_to_non_nullable
as String?,localVersion: freezed == localVersion ? _self.localVersion : localVersion // ignore: cast_nullable_to_non_nullable
as int?,installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,sameVersionInstalled: null == sameVersionInstalled ? _self.sameVersionInstalled : sameVersionInstalled // ignore: cast_nullable_to_non_nullable
as bool,updateAvailable: null == updateAvailable ? _self.updateAvailable : updateAvailable // ignore: cast_nullable_to_non_nullable
as bool,repairAvailable: null == repairAvailable ? _self.repairAvailable : repairAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$StoreDownloadProgress {

 String get packId; int get receivedBytes; int get totalBytes; int get completedAssets; int get totalAssets;
/// Create a copy of StoreDownloadProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreDownloadProgressCopyWith<StoreDownloadProgress> get copyWith => _$StoreDownloadProgressCopyWithImpl<StoreDownloadProgress>(this as StoreDownloadProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreDownloadProgress&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.receivedBytes, receivedBytes) || other.receivedBytes == receivedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.completedAssets, completedAssets) || other.completedAssets == completedAssets)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets));
}


@override
int get hashCode => Object.hash(runtimeType,packId,receivedBytes,totalBytes,completedAssets,totalAssets);

@override
String toString() {
  return 'StoreDownloadProgress(packId: $packId, receivedBytes: $receivedBytes, totalBytes: $totalBytes, completedAssets: $completedAssets, totalAssets: $totalAssets)';
}


}

/// @nodoc
abstract mixin class $StoreDownloadProgressCopyWith<$Res>  {
  factory $StoreDownloadProgressCopyWith(StoreDownloadProgress value, $Res Function(StoreDownloadProgress) _then) = _$StoreDownloadProgressCopyWithImpl;
@useResult
$Res call({
 String packId, int receivedBytes, int totalBytes, int completedAssets, int totalAssets
});




}
/// @nodoc
class _$StoreDownloadProgressCopyWithImpl<$Res>
    implements $StoreDownloadProgressCopyWith<$Res> {
  _$StoreDownloadProgressCopyWithImpl(this._self, this._then);

  final StoreDownloadProgress _self;
  final $Res Function(StoreDownloadProgress) _then;

/// Create a copy of StoreDownloadProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packId = null,Object? receivedBytes = null,Object? totalBytes = null,Object? completedAssets = null,Object? totalAssets = null,}) {
  return _then(_self.copyWith(
packId: null == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String,receivedBytes: null == receivedBytes ? _self.receivedBytes : receivedBytes // ignore: cast_nullable_to_non_nullable
as int,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,completedAssets: null == completedAssets ? _self.completedAssets : completedAssets // ignore: cast_nullable_to_non_nullable
as int,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreDownloadProgress].
extension StoreDownloadProgressPatterns on StoreDownloadProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreDownloadProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreDownloadProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreDownloadProgress value)  $default,){
final _that = this;
switch (_that) {
case _StoreDownloadProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreDownloadProgress value)?  $default,){
final _that = this;
switch (_that) {
case _StoreDownloadProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String packId,  int receivedBytes,  int totalBytes,  int completedAssets,  int totalAssets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreDownloadProgress() when $default != null:
return $default(_that.packId,_that.receivedBytes,_that.totalBytes,_that.completedAssets,_that.totalAssets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String packId,  int receivedBytes,  int totalBytes,  int completedAssets,  int totalAssets)  $default,) {final _that = this;
switch (_that) {
case _StoreDownloadProgress():
return $default(_that.packId,_that.receivedBytes,_that.totalBytes,_that.completedAssets,_that.totalAssets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String packId,  int receivedBytes,  int totalBytes,  int completedAssets,  int totalAssets)?  $default,) {final _that = this;
switch (_that) {
case _StoreDownloadProgress() when $default != null:
return $default(_that.packId,_that.receivedBytes,_that.totalBytes,_that.completedAssets,_that.totalAssets);case _:
  return null;

}
}

}

/// @nodoc


class _StoreDownloadProgress extends StoreDownloadProgress {
  const _StoreDownloadProgress({required this.packId, this.receivedBytes = 0, this.totalBytes = 0, this.completedAssets = 0, this.totalAssets = 0}): super._();
  

@override final  String packId;
@override@JsonKey() final  int receivedBytes;
@override@JsonKey() final  int totalBytes;
@override@JsonKey() final  int completedAssets;
@override@JsonKey() final  int totalAssets;

/// Create a copy of StoreDownloadProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreDownloadProgressCopyWith<_StoreDownloadProgress> get copyWith => __$StoreDownloadProgressCopyWithImpl<_StoreDownloadProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreDownloadProgress&&(identical(other.packId, packId) || other.packId == packId)&&(identical(other.receivedBytes, receivedBytes) || other.receivedBytes == receivedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.completedAssets, completedAssets) || other.completedAssets == completedAssets)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets));
}


@override
int get hashCode => Object.hash(runtimeType,packId,receivedBytes,totalBytes,completedAssets,totalAssets);

@override
String toString() {
  return 'StoreDownloadProgress(packId: $packId, receivedBytes: $receivedBytes, totalBytes: $totalBytes, completedAssets: $completedAssets, totalAssets: $totalAssets)';
}


}

/// @nodoc
abstract mixin class _$StoreDownloadProgressCopyWith<$Res> implements $StoreDownloadProgressCopyWith<$Res> {
  factory _$StoreDownloadProgressCopyWith(_StoreDownloadProgress value, $Res Function(_StoreDownloadProgress) _then) = __$StoreDownloadProgressCopyWithImpl;
@override @useResult
$Res call({
 String packId, int receivedBytes, int totalBytes, int completedAssets, int totalAssets
});




}
/// @nodoc
class __$StoreDownloadProgressCopyWithImpl<$Res>
    implements _$StoreDownloadProgressCopyWith<$Res> {
  __$StoreDownloadProgressCopyWithImpl(this._self, this._then);

  final _StoreDownloadProgress _self;
  final $Res Function(_StoreDownloadProgress) _then;

/// Create a copy of StoreDownloadProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packId = null,Object? receivedBytes = null,Object? totalBytes = null,Object? completedAssets = null,Object? totalAssets = null,}) {
  return _then(_StoreDownloadProgress(
packId: null == packId ? _self.packId : packId // ignore: cast_nullable_to_non_nullable
as String,receivedBytes: null == receivedBytes ? _self.receivedBytes : receivedBytes // ignore: cast_nullable_to_non_nullable
as int,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,completedAssets: null == completedAssets ? _self.completedAssets : completedAssets // ignore: cast_nullable_to_non_nullable
as int,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StorePackDetail {

 StoreRemotePack get remote; StoreLocalPackStatus get localStatus; StickerPack? get localPack;
/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorePackDetailCopyWith<StorePackDetail> get copyWith => _$StorePackDetailCopyWithImpl<StorePackDetail>(this as StorePackDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorePackDetail&&(identical(other.remote, remote) || other.remote == remote)&&(identical(other.localStatus, localStatus) || other.localStatus == localStatus)&&(identical(other.localPack, localPack) || other.localPack == localPack));
}


@override
int get hashCode => Object.hash(runtimeType,remote,localStatus,localPack);

@override
String toString() {
  return 'StorePackDetail(remote: $remote, localStatus: $localStatus, localPack: $localPack)';
}


}

/// @nodoc
abstract mixin class $StorePackDetailCopyWith<$Res>  {
  factory $StorePackDetailCopyWith(StorePackDetail value, $Res Function(StorePackDetail) _then) = _$StorePackDetailCopyWithImpl;
@useResult
$Res call({
 StoreRemotePack remote, StoreLocalPackStatus localStatus, StickerPack? localPack
});


$StoreRemotePackCopyWith<$Res> get remote;$StoreLocalPackStatusCopyWith<$Res> get localStatus;$StickerPackCopyWith<$Res>? get localPack;

}
/// @nodoc
class _$StorePackDetailCopyWithImpl<$Res>
    implements $StorePackDetailCopyWith<$Res> {
  _$StorePackDetailCopyWithImpl(this._self, this._then);

  final StorePackDetail _self;
  final $Res Function(StorePackDetail) _then;

/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remote = null,Object? localStatus = null,Object? localPack = freezed,}) {
  return _then(_self.copyWith(
remote: null == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as StoreRemotePack,localStatus: null == localStatus ? _self.localStatus : localStatus // ignore: cast_nullable_to_non_nullable
as StoreLocalPackStatus,localPack: freezed == localPack ? _self.localPack : localPack // ignore: cast_nullable_to_non_nullable
as StickerPack?,
  ));
}
/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreRemotePackCopyWith<$Res> get remote {
  
  return $StoreRemotePackCopyWith<$Res>(_self.remote, (value) {
    return _then(_self.copyWith(remote: value));
  });
}/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreLocalPackStatusCopyWith<$Res> get localStatus {
  
  return $StoreLocalPackStatusCopyWith<$Res>(_self.localStatus, (value) {
    return _then(_self.copyWith(localStatus: value));
  });
}/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StickerPackCopyWith<$Res>? get localPack {
    if (_self.localPack == null) {
    return null;
  }

  return $StickerPackCopyWith<$Res>(_self.localPack!, (value) {
    return _then(_self.copyWith(localPack: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorePackDetail].
extension StorePackDetailPatterns on StorePackDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorePackDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorePackDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorePackDetail value)  $default,){
final _that = this;
switch (_that) {
case _StorePackDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorePackDetail value)?  $default,){
final _that = this;
switch (_that) {
case _StorePackDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoreRemotePack remote,  StoreLocalPackStatus localStatus,  StickerPack? localPack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorePackDetail() when $default != null:
return $default(_that.remote,_that.localStatus,_that.localPack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoreRemotePack remote,  StoreLocalPackStatus localStatus,  StickerPack? localPack)  $default,) {final _that = this;
switch (_that) {
case _StorePackDetail():
return $default(_that.remote,_that.localStatus,_that.localPack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoreRemotePack remote,  StoreLocalPackStatus localStatus,  StickerPack? localPack)?  $default,) {final _that = this;
switch (_that) {
case _StorePackDetail() when $default != null:
return $default(_that.remote,_that.localStatus,_that.localPack);case _:
  return null;

}
}

}

/// @nodoc


class _StorePackDetail implements StorePackDetail {
  const _StorePackDetail({required this.remote, required this.localStatus, this.localPack});
  

@override final  StoreRemotePack remote;
@override final  StoreLocalPackStatus localStatus;
@override final  StickerPack? localPack;

/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorePackDetailCopyWith<_StorePackDetail> get copyWith => __$StorePackDetailCopyWithImpl<_StorePackDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorePackDetail&&(identical(other.remote, remote) || other.remote == remote)&&(identical(other.localStatus, localStatus) || other.localStatus == localStatus)&&(identical(other.localPack, localPack) || other.localPack == localPack));
}


@override
int get hashCode => Object.hash(runtimeType,remote,localStatus,localPack);

@override
String toString() {
  return 'StorePackDetail(remote: $remote, localStatus: $localStatus, localPack: $localPack)';
}


}

/// @nodoc
abstract mixin class _$StorePackDetailCopyWith<$Res> implements $StorePackDetailCopyWith<$Res> {
  factory _$StorePackDetailCopyWith(_StorePackDetail value, $Res Function(_StorePackDetail) _then) = __$StorePackDetailCopyWithImpl;
@override @useResult
$Res call({
 StoreRemotePack remote, StoreLocalPackStatus localStatus, StickerPack? localPack
});


@override $StoreRemotePackCopyWith<$Res> get remote;@override $StoreLocalPackStatusCopyWith<$Res> get localStatus;@override $StickerPackCopyWith<$Res>? get localPack;

}
/// @nodoc
class __$StorePackDetailCopyWithImpl<$Res>
    implements _$StorePackDetailCopyWith<$Res> {
  __$StorePackDetailCopyWithImpl(this._self, this._then);

  final _StorePackDetail _self;
  final $Res Function(_StorePackDetail) _then;

/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remote = null,Object? localStatus = null,Object? localPack = freezed,}) {
  return _then(_StorePackDetail(
remote: null == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as StoreRemotePack,localStatus: null == localStatus ? _self.localStatus : localStatus // ignore: cast_nullable_to_non_nullable
as StoreLocalPackStatus,localPack: freezed == localPack ? _self.localPack : localPack // ignore: cast_nullable_to_non_nullable
as StickerPack?,
  ));
}

/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreRemotePackCopyWith<$Res> get remote {
  
  return $StoreRemotePackCopyWith<$Res>(_self.remote, (value) {
    return _then(_self.copyWith(remote: value));
  });
}/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreLocalPackStatusCopyWith<$Res> get localStatus {
  
  return $StoreLocalPackStatusCopyWith<$Res>(_self.localStatus, (value) {
    return _then(_self.copyWith(localStatus: value));
  });
}/// Create a copy of StorePackDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StickerPackCopyWith<$Res>? get localPack {
    if (_self.localPack == null) {
    return null;
  }

  return $StickerPackCopyWith<$Res>(_self.localPack!, (value) {
    return _then(_self.copyWith(localPack: value));
  });
}
}

/// @nodoc
mixin _$StoreCatalogSnapshot {

 StoreCatalog get catalog; Map<String, StoreLocalPackStatus> get localStatuses; Map<String, StorePackDetail> get packDetails;
/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCatalogSnapshotCopyWith<StoreCatalogSnapshot> get copyWith => _$StoreCatalogSnapshotCopyWithImpl<StoreCatalogSnapshot>(this as StoreCatalogSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreCatalogSnapshot&&(identical(other.catalog, catalog) || other.catalog == catalog)&&const DeepCollectionEquality().equals(other.localStatuses, localStatuses)&&const DeepCollectionEquality().equals(other.packDetails, packDetails));
}


@override
int get hashCode => Object.hash(runtimeType,catalog,const DeepCollectionEquality().hash(localStatuses),const DeepCollectionEquality().hash(packDetails));

@override
String toString() {
  return 'StoreCatalogSnapshot(catalog: $catalog, localStatuses: $localStatuses, packDetails: $packDetails)';
}


}

/// @nodoc
abstract mixin class $StoreCatalogSnapshotCopyWith<$Res>  {
  factory $StoreCatalogSnapshotCopyWith(StoreCatalogSnapshot value, $Res Function(StoreCatalogSnapshot) _then) = _$StoreCatalogSnapshotCopyWithImpl;
@useResult
$Res call({
 StoreCatalog catalog, Map<String, StoreLocalPackStatus> localStatuses, Map<String, StorePackDetail> packDetails
});


$StoreCatalogCopyWith<$Res> get catalog;

}
/// @nodoc
class _$StoreCatalogSnapshotCopyWithImpl<$Res>
    implements $StoreCatalogSnapshotCopyWith<$Res> {
  _$StoreCatalogSnapshotCopyWithImpl(this._self, this._then);

  final StoreCatalogSnapshot _self;
  final $Res Function(StoreCatalogSnapshot) _then;

/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? catalog = null,Object? localStatuses = null,Object? packDetails = null,}) {
  return _then(_self.copyWith(
catalog: null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as StoreCatalog,localStatuses: null == localStatuses ? _self.localStatuses : localStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, StoreLocalPackStatus>,packDetails: null == packDetails ? _self.packDetails : packDetails // ignore: cast_nullable_to_non_nullable
as Map<String, StorePackDetail>,
  ));
}
/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreCatalogCopyWith<$Res> get catalog {
  
  return $StoreCatalogCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoreCatalogSnapshot].
extension StoreCatalogSnapshotPatterns on StoreCatalogSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreCatalogSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreCatalogSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreCatalogSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _StoreCatalogSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreCatalogSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _StoreCatalogSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoreCatalog catalog,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StorePackDetail> packDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreCatalogSnapshot() when $default != null:
return $default(_that.catalog,_that.localStatuses,_that.packDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoreCatalog catalog,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StorePackDetail> packDetails)  $default,) {final _that = this;
switch (_that) {
case _StoreCatalogSnapshot():
return $default(_that.catalog,_that.localStatuses,_that.packDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoreCatalog catalog,  Map<String, StoreLocalPackStatus> localStatuses,  Map<String, StorePackDetail> packDetails)?  $default,) {final _that = this;
switch (_that) {
case _StoreCatalogSnapshot() when $default != null:
return $default(_that.catalog,_that.localStatuses,_that.packDetails);case _:
  return null;

}
}

}

/// @nodoc


class _StoreCatalogSnapshot implements StoreCatalogSnapshot {
  const _StoreCatalogSnapshot({required this.catalog,  Map<String, StoreLocalPackStatus> localStatuses = const <String, StoreLocalPackStatus>{},  Map<String, StorePackDetail> packDetails = const <String, StorePackDetail>{}}): _localStatuses = localStatuses,_packDetails = packDetails;
  

@override final  StoreCatalog catalog;
 final  Map<String, StoreLocalPackStatus> _localStatuses;
@override@JsonKey() Map<String, StoreLocalPackStatus> get localStatuses {
  if (_localStatuses is EqualUnmodifiableMapView) return _localStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_localStatuses);
}

 final  Map<String, StorePackDetail> _packDetails;
@override@JsonKey() Map<String, StorePackDetail> get packDetails {
  if (_packDetails is EqualUnmodifiableMapView) return _packDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_packDetails);
}


/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCatalogSnapshotCopyWith<_StoreCatalogSnapshot> get copyWith => __$StoreCatalogSnapshotCopyWithImpl<_StoreCatalogSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreCatalogSnapshot&&(identical(other.catalog, catalog) || other.catalog == catalog)&&const DeepCollectionEquality().equals(other._localStatuses, _localStatuses)&&const DeepCollectionEquality().equals(other._packDetails, _packDetails));
}


@override
int get hashCode => Object.hash(runtimeType,catalog,const DeepCollectionEquality().hash(_localStatuses),const DeepCollectionEquality().hash(_packDetails));

@override
String toString() {
  return 'StoreCatalogSnapshot(catalog: $catalog, localStatuses: $localStatuses, packDetails: $packDetails)';
}


}

/// @nodoc
abstract mixin class _$StoreCatalogSnapshotCopyWith<$Res> implements $StoreCatalogSnapshotCopyWith<$Res> {
  factory _$StoreCatalogSnapshotCopyWith(_StoreCatalogSnapshot value, $Res Function(_StoreCatalogSnapshot) _then) = __$StoreCatalogSnapshotCopyWithImpl;
@override @useResult
$Res call({
 StoreCatalog catalog, Map<String, StoreLocalPackStatus> localStatuses, Map<String, StorePackDetail> packDetails
});


@override $StoreCatalogCopyWith<$Res> get catalog;

}
/// @nodoc
class __$StoreCatalogSnapshotCopyWithImpl<$Res>
    implements _$StoreCatalogSnapshotCopyWith<$Res> {
  __$StoreCatalogSnapshotCopyWithImpl(this._self, this._then);

  final _StoreCatalogSnapshot _self;
  final $Res Function(_StoreCatalogSnapshot) _then;

/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? catalog = null,Object? localStatuses = null,Object? packDetails = null,}) {
  return _then(_StoreCatalogSnapshot(
catalog: null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as StoreCatalog,localStatuses: null == localStatuses ? _self._localStatuses : localStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, StoreLocalPackStatus>,packDetails: null == packDetails ? _self._packDetails : packDetails // ignore: cast_nullable_to_non_nullable
as Map<String, StorePackDetail>,
  ));
}

/// Create a copy of StoreCatalogSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreCatalogCopyWith<$Res> get catalog {
  
  return $StoreCatalogCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}

// dart format on
