import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/constants/constants.dart';

part 'process_models.freezed.dart';

enum ProcessOutputType { sticker, tray }

enum CropPolicy { cover, contain }

@freezed
abstract class ProcessRequest with _$ProcessRequest {
  @Assert(EditorMessages.processRequestSourceAssert)
  const factory ProcessRequest({
    String? sourcePath,
    Uint8List? sourceBytes,
    required ProcessOutputType outputType,
    required int targetSize,
    required int maxBytes,
    int? stickerIndex,
    @Default(CropPolicy.cover) CropPolicy cropPolicy,
    @Default(true) bool transparentBackgroundPreferred,
  }) = _ProcessRequest;
}

@freezed
abstract class ProcessResult with _$ProcessResult {
  const factory ProcessResult({
    required String outputPath,
    required String fileName,
    required int sizeBytes,
    required int width,
    required int height,
    @Default(false) bool animated,
    @Default(false) bool validationPassed,
  }) = _ProcessResult;
}
