// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'process_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProcessRequest {

 String? get sourcePath; Uint8List? get sourceBytes; ProcessOutputType get outputType; int get targetSize; int get maxBytes; int? get stickerIndex; CropPolicy get cropPolicy; bool get transparentBackgroundPreferred;
/// Create a copy of ProcessRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcessRequestCopyWith<ProcessRequest> get copyWith => _$ProcessRequestCopyWithImpl<ProcessRequest>(this as ProcessRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessRequest&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&const DeepCollectionEquality().equals(other.sourceBytes, sourceBytes)&&(identical(other.outputType, outputType) || other.outputType == outputType)&&(identical(other.targetSize, targetSize) || other.targetSize == targetSize)&&(identical(other.maxBytes, maxBytes) || other.maxBytes == maxBytes)&&(identical(other.stickerIndex, stickerIndex) || other.stickerIndex == stickerIndex)&&(identical(other.cropPolicy, cropPolicy) || other.cropPolicy == cropPolicy)&&(identical(other.transparentBackgroundPreferred, transparentBackgroundPreferred) || other.transparentBackgroundPreferred == transparentBackgroundPreferred));
}


@override
int get hashCode => Object.hash(runtimeType,sourcePath,const DeepCollectionEquality().hash(sourceBytes),outputType,targetSize,maxBytes,stickerIndex,cropPolicy,transparentBackgroundPreferred);

@override
String toString() {
  return 'ProcessRequest(sourcePath: $sourcePath, sourceBytes: $sourceBytes, outputType: $outputType, targetSize: $targetSize, maxBytes: $maxBytes, stickerIndex: $stickerIndex, cropPolicy: $cropPolicy, transparentBackgroundPreferred: $transparentBackgroundPreferred)';
}


}

/// @nodoc
abstract mixin class $ProcessRequestCopyWith<$Res>  {
  factory $ProcessRequestCopyWith(ProcessRequest value, $Res Function(ProcessRequest) _then) = _$ProcessRequestCopyWithImpl;
@useResult
$Res call({
 String? sourcePath, Uint8List? sourceBytes, ProcessOutputType outputType, int targetSize, int maxBytes, int? stickerIndex, CropPolicy cropPolicy, bool transparentBackgroundPreferred
});




}
/// @nodoc
class _$ProcessRequestCopyWithImpl<$Res>
    implements $ProcessRequestCopyWith<$Res> {
  _$ProcessRequestCopyWithImpl(this._self, this._then);

  final ProcessRequest _self;
  final $Res Function(ProcessRequest) _then;

/// Create a copy of ProcessRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourcePath = freezed,Object? sourceBytes = freezed,Object? outputType = null,Object? targetSize = null,Object? maxBytes = null,Object? stickerIndex = freezed,Object? cropPolicy = null,Object? transparentBackgroundPreferred = null,}) {
  return _then(_self.copyWith(
sourcePath: freezed == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String?,sourceBytes: freezed == sourceBytes ? _self.sourceBytes : sourceBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,outputType: null == outputType ? _self.outputType : outputType // ignore: cast_nullable_to_non_nullable
as ProcessOutputType,targetSize: null == targetSize ? _self.targetSize : targetSize // ignore: cast_nullable_to_non_nullable
as int,maxBytes: null == maxBytes ? _self.maxBytes : maxBytes // ignore: cast_nullable_to_non_nullable
as int,stickerIndex: freezed == stickerIndex ? _self.stickerIndex : stickerIndex // ignore: cast_nullable_to_non_nullable
as int?,cropPolicy: null == cropPolicy ? _self.cropPolicy : cropPolicy // ignore: cast_nullable_to_non_nullable
as CropPolicy,transparentBackgroundPreferred: null == transparentBackgroundPreferred ? _self.transparentBackgroundPreferred : transparentBackgroundPreferred // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcessRequest].
extension ProcessRequestPatterns on ProcessRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcessRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcessRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcessRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProcessRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcessRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProcessRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sourcePath,  Uint8List? sourceBytes,  ProcessOutputType outputType,  int targetSize,  int maxBytes,  int? stickerIndex,  CropPolicy cropPolicy,  bool transparentBackgroundPreferred)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcessRequest() when $default != null:
return $default(_that.sourcePath,_that.sourceBytes,_that.outputType,_that.targetSize,_that.maxBytes,_that.stickerIndex,_that.cropPolicy,_that.transparentBackgroundPreferred);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sourcePath,  Uint8List? sourceBytes,  ProcessOutputType outputType,  int targetSize,  int maxBytes,  int? stickerIndex,  CropPolicy cropPolicy,  bool transparentBackgroundPreferred)  $default,) {final _that = this;
switch (_that) {
case _ProcessRequest():
return $default(_that.sourcePath,_that.sourceBytes,_that.outputType,_that.targetSize,_that.maxBytes,_that.stickerIndex,_that.cropPolicy,_that.transparentBackgroundPreferred);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sourcePath,  Uint8List? sourceBytes,  ProcessOutputType outputType,  int targetSize,  int maxBytes,  int? stickerIndex,  CropPolicy cropPolicy,  bool transparentBackgroundPreferred)?  $default,) {final _that = this;
switch (_that) {
case _ProcessRequest() when $default != null:
return $default(_that.sourcePath,_that.sourceBytes,_that.outputType,_that.targetSize,_that.maxBytes,_that.stickerIndex,_that.cropPolicy,_that.transparentBackgroundPreferred);case _:
  return null;

}
}

}

/// @nodoc


class _ProcessRequest implements ProcessRequest {
  const _ProcessRequest({this.sourcePath, this.sourceBytes, required this.outputType, required this.targetSize, required this.maxBytes, this.stickerIndex, this.cropPolicy = CropPolicy.cover, this.transparentBackgroundPreferred = true}): assert(sourcePath != null || sourceBytes != null);
  

@override final  String? sourcePath;
@override final  Uint8List? sourceBytes;
@override final  ProcessOutputType outputType;
@override final  int targetSize;
@override final  int maxBytes;
@override final  int? stickerIndex;
@override@JsonKey() final  CropPolicy cropPolicy;
@override@JsonKey() final  bool transparentBackgroundPreferred;

/// Create a copy of ProcessRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcessRequestCopyWith<_ProcessRequest> get copyWith => __$ProcessRequestCopyWithImpl<_ProcessRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcessRequest&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&const DeepCollectionEquality().equals(other.sourceBytes, sourceBytes)&&(identical(other.outputType, outputType) || other.outputType == outputType)&&(identical(other.targetSize, targetSize) || other.targetSize == targetSize)&&(identical(other.maxBytes, maxBytes) || other.maxBytes == maxBytes)&&(identical(other.stickerIndex, stickerIndex) || other.stickerIndex == stickerIndex)&&(identical(other.cropPolicy, cropPolicy) || other.cropPolicy == cropPolicy)&&(identical(other.transparentBackgroundPreferred, transparentBackgroundPreferred) || other.transparentBackgroundPreferred == transparentBackgroundPreferred));
}


@override
int get hashCode => Object.hash(runtimeType,sourcePath,const DeepCollectionEquality().hash(sourceBytes),outputType,targetSize,maxBytes,stickerIndex,cropPolicy,transparentBackgroundPreferred);

@override
String toString() {
  return 'ProcessRequest(sourcePath: $sourcePath, sourceBytes: $sourceBytes, outputType: $outputType, targetSize: $targetSize, maxBytes: $maxBytes, stickerIndex: $stickerIndex, cropPolicy: $cropPolicy, transparentBackgroundPreferred: $transparentBackgroundPreferred)';
}


}

/// @nodoc
abstract mixin class _$ProcessRequestCopyWith<$Res> implements $ProcessRequestCopyWith<$Res> {
  factory _$ProcessRequestCopyWith(_ProcessRequest value, $Res Function(_ProcessRequest) _then) = __$ProcessRequestCopyWithImpl;
@override @useResult
$Res call({
 String? sourcePath, Uint8List? sourceBytes, ProcessOutputType outputType, int targetSize, int maxBytes, int? stickerIndex, CropPolicy cropPolicy, bool transparentBackgroundPreferred
});




}
/// @nodoc
class __$ProcessRequestCopyWithImpl<$Res>
    implements _$ProcessRequestCopyWith<$Res> {
  __$ProcessRequestCopyWithImpl(this._self, this._then);

  final _ProcessRequest _self;
  final $Res Function(_ProcessRequest) _then;

/// Create a copy of ProcessRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourcePath = freezed,Object? sourceBytes = freezed,Object? outputType = null,Object? targetSize = null,Object? maxBytes = null,Object? stickerIndex = freezed,Object? cropPolicy = null,Object? transparentBackgroundPreferred = null,}) {
  return _then(_ProcessRequest(
sourcePath: freezed == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String?,sourceBytes: freezed == sourceBytes ? _self.sourceBytes : sourceBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,outputType: null == outputType ? _self.outputType : outputType // ignore: cast_nullable_to_non_nullable
as ProcessOutputType,targetSize: null == targetSize ? _self.targetSize : targetSize // ignore: cast_nullable_to_non_nullable
as int,maxBytes: null == maxBytes ? _self.maxBytes : maxBytes // ignore: cast_nullable_to_non_nullable
as int,stickerIndex: freezed == stickerIndex ? _self.stickerIndex : stickerIndex // ignore: cast_nullable_to_non_nullable
as int?,cropPolicy: null == cropPolicy ? _self.cropPolicy : cropPolicy // ignore: cast_nullable_to_non_nullable
as CropPolicy,transparentBackgroundPreferred: null == transparentBackgroundPreferred ? _self.transparentBackgroundPreferred : transparentBackgroundPreferred // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ProcessResult {

 String get outputPath; String get fileName; int get sizeBytes; int get width; int get height; bool get animated; bool get validationPassed;
/// Create a copy of ProcessResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcessResultCopyWith<ProcessResult> get copyWith => _$ProcessResultCopyWithImpl<ProcessResult>(this as ProcessResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessResult&&(identical(other.outputPath, outputPath) || other.outputPath == outputPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.validationPassed, validationPassed) || other.validationPassed == validationPassed));
}


@override
int get hashCode => Object.hash(runtimeType,outputPath,fileName,sizeBytes,width,height,animated,validationPassed);

@override
String toString() {
  return 'ProcessResult(outputPath: $outputPath, fileName: $fileName, sizeBytes: $sizeBytes, width: $width, height: $height, animated: $animated, validationPassed: $validationPassed)';
}


}

/// @nodoc
abstract mixin class $ProcessResultCopyWith<$Res>  {
  factory $ProcessResultCopyWith(ProcessResult value, $Res Function(ProcessResult) _then) = _$ProcessResultCopyWithImpl;
@useResult
$Res call({
 String outputPath, String fileName, int sizeBytes, int width, int height, bool animated, bool validationPassed
});




}
/// @nodoc
class _$ProcessResultCopyWithImpl<$Res>
    implements $ProcessResultCopyWith<$Res> {
  _$ProcessResultCopyWithImpl(this._self, this._then);

  final ProcessResult _self;
  final $Res Function(ProcessResult) _then;

/// Create a copy of ProcessResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outputPath = null,Object? fileName = null,Object? sizeBytes = null,Object? width = null,Object? height = null,Object? animated = null,Object? validationPassed = null,}) {
  return _then(_self.copyWith(
outputPath: null == outputPath ? _self.outputPath : outputPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,validationPassed: null == validationPassed ? _self.validationPassed : validationPassed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcessResult].
extension ProcessResultPatterns on ProcessResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcessResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcessResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcessResult value)  $default,){
final _that = this;
switch (_that) {
case _ProcessResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcessResult value)?  $default,){
final _that = this;
switch (_that) {
case _ProcessResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String outputPath,  String fileName,  int sizeBytes,  int width,  int height,  bool animated,  bool validationPassed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcessResult() when $default != null:
return $default(_that.outputPath,_that.fileName,_that.sizeBytes,_that.width,_that.height,_that.animated,_that.validationPassed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String outputPath,  String fileName,  int sizeBytes,  int width,  int height,  bool animated,  bool validationPassed)  $default,) {final _that = this;
switch (_that) {
case _ProcessResult():
return $default(_that.outputPath,_that.fileName,_that.sizeBytes,_that.width,_that.height,_that.animated,_that.validationPassed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String outputPath,  String fileName,  int sizeBytes,  int width,  int height,  bool animated,  bool validationPassed)?  $default,) {final _that = this;
switch (_that) {
case _ProcessResult() when $default != null:
return $default(_that.outputPath,_that.fileName,_that.sizeBytes,_that.width,_that.height,_that.animated,_that.validationPassed);case _:
  return null;

}
}

}

/// @nodoc


class _ProcessResult implements ProcessResult {
  const _ProcessResult({required this.outputPath, required this.fileName, required this.sizeBytes, required this.width, required this.height, this.animated = false, this.validationPassed = false});
  

@override final  String outputPath;
@override final  String fileName;
@override final  int sizeBytes;
@override final  int width;
@override final  int height;
@override@JsonKey() final  bool animated;
@override@JsonKey() final  bool validationPassed;

/// Create a copy of ProcessResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcessResultCopyWith<_ProcessResult> get copyWith => __$ProcessResultCopyWithImpl<_ProcessResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcessResult&&(identical(other.outputPath, outputPath) || other.outputPath == outputPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.animated, animated) || other.animated == animated)&&(identical(other.validationPassed, validationPassed) || other.validationPassed == validationPassed));
}


@override
int get hashCode => Object.hash(runtimeType,outputPath,fileName,sizeBytes,width,height,animated,validationPassed);

@override
String toString() {
  return 'ProcessResult(outputPath: $outputPath, fileName: $fileName, sizeBytes: $sizeBytes, width: $width, height: $height, animated: $animated, validationPassed: $validationPassed)';
}


}

/// @nodoc
abstract mixin class _$ProcessResultCopyWith<$Res> implements $ProcessResultCopyWith<$Res> {
  factory _$ProcessResultCopyWith(_ProcessResult value, $Res Function(_ProcessResult) _then) = __$ProcessResultCopyWithImpl;
@override @useResult
$Res call({
 String outputPath, String fileName, int sizeBytes, int width, int height, bool animated, bool validationPassed
});




}
/// @nodoc
class __$ProcessResultCopyWithImpl<$Res>
    implements _$ProcessResultCopyWith<$Res> {
  __$ProcessResultCopyWithImpl(this._self, this._then);

  final _ProcessResult _self;
  final $Res Function(_ProcessResult) _then;

/// Create a copy of ProcessResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outputPath = null,Object? fileName = null,Object? sizeBytes = null,Object? width = null,Object? height = null,Object? animated = null,Object? validationPassed = null,}) {
  return _then(_ProcessResult(
outputPath: null == outputPath ? _self.outputPath : outputPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,animated: null == animated ? _self.animated : animated // ignore: cast_nullable_to_non_nullable
as bool,validationPassed: null == validationPassed ? _self.validationPassed : validationPassed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
