import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_bicubic_resize/flutter_bicubic_resize.dart';
import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../../core/util/mime.dart';
import '../domain/process_models.dart';
import 'webp_encoder.dart';

class StickerProcessor {
  StickerProcessor(this._operationRoot, this._encoder);

  final Future<Directory> Function() _operationRoot;
  final WebpEncoder _encoder;

  Future<AppResult<ProcessResult>> process(ProcessRequest request) async {
    final operationDir = await _operationRoot();
    try {
      final sourceBytes =
          request.sourceBytes ?? await File(request.sourcePath!).readAsBytes();
      final sourceMime = MimeUtil.detect(sourceBytes);
      if (sourceMime != ImageMimeType.jpeg && sourceMime != ImageMimeType.png) {
        return const AppResult.failure(
          AppError.validation(message: EditorMessages.outputMustBeJpegOrPng),
        );
      }

      final normalizedBytes = await _normalizeSource(
        sourceBytes: sourceBytes,
        sourceMime: sourceMime!,
        request: request,
      );
      final encodedBytes = await _encodeWithinLimit(
        normalizedBytes,
        maxBytes: request.maxBytes,
        preferLossless:
            request.transparentBackgroundPreferred ||
            sourceMime == ImageMimeType.png,
      );

      final fileName = request.outputType == ProcessOutputType.tray
          ? PackFiles.trayFileName
          : PackFiles.stickerFileName((request.stickerIndex ?? 0) + 1);
      final outputPath = p.join(operationDir.path, fileName);
      await _writeBytesAtomic(outputPath, encodedBytes);

      return AppResult.success(
        ProcessResult(
          outputPath: outputPath,
          fileName: fileName,
          sizeBytes: encodedBytes.length,
          width: request.targetSize,
          height: request.targetSize,
          validationPassed: true,
        ),
      );
    } on UnsupportedImageFormatException catch (error) {
      await _deleteDirectoryIfExists(operationDir.path);
      return AppResult.failure(
        AppError.validation(
          message: EditorMessages.unsupportedImageFormat,
          debugDetails: error.toString(),
        ),
      );
    } on BicubicResizeException catch (error) {
      await _deleteDirectoryIfExists(operationDir.path);
      return AppResult.failure(
        AppError.validation(
          message: EditorMessages.imageResizingFailed,
          debugDetails: error.toString(),
        ),
      );
    } on Object catch (error) {
      await _deleteDirectoryIfExists(operationDir.path);
      return AppResult.failure(
        AppError.unknown(
          message: EditorMessages.stickerProcessingFailed,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<Uint8List> _normalizeSource({
    required Uint8List sourceBytes,
    required ImageMimeType sourceMime,
    required ProcessRequest request,
  }) async {
    if (request.cropPolicy == CropPolicy.contain) {
      return _normalizeContain(sourceBytes, request.targetSize);
    }
    return Isolate.run(() {
      return BicubicResizer.resize(
        bytes: sourceBytes,
        outputWidth: request.targetSize,
        outputHeight: request.targetSize,
        quality: 100,
        compressionLevel: 6,
        filter: BicubicFilter.catmullRom,
        cropAspectRatio: CropAspectRatio.square,
        cropAnchor: CropAnchor.center,
      );
    });
  }

  Future<Uint8List> _normalizeContain(
    Uint8List sourceBytes,
    int targetSize,
  ) async {
    final codec = await ui.instantiateImageCodec(sourceBytes);
    final frame = await codec.getNextFrame();
    final sourceImage = frame.image;
    final scale = sourceImage.width > sourceImage.height
        ? targetSize / sourceImage.width
        : targetSize / sourceImage.height;
    final destinationWidth = sourceImage.width * scale;
    final destinationHeight = sourceImage.height * scale;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final left = (targetSize - destinationWidth) / 2;
    final top = (targetSize - destinationHeight) / 2;
    canvas.drawImageRect(
      sourceImage,
      ui.Rect.fromLTWH(
        0,
        0,
        sourceImage.width.toDouble(),
        sourceImage.height.toDouble(),
      ),
      ui.Rect.fromLTWH(left, top, destinationWidth, destinationHeight),
      ui.Paint()..filterQuality = ui.FilterQuality.high,
    );
    final image = await recorder.endRecording().toImage(targetSize, targetSize);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) {
      throw StateError(EditorMessages.imageSerializationFailed);
    }
    return data.buffer.asUint8List();
  }

  Future<Uint8List> _encodeWithinLimit(
    Uint8List normalizedBytes, {
    required int maxBytes,
    required bool preferLossless,
  }) async {
    if (preferLossless) {
      final lossless = await _encoder.encodeWebp(
        bytes: normalizedBytes,
        quality: 100,
        lossless: true,
      );
      if (lossless.length <= maxBytes) {
        return lossless;
      }
    }

    Uint8List? best;
    Uint8List? smallest;
    var low = 0;
    var high = 100;

    while (low <= high) {
      final quality = low + ((high - low) >> 1);
      final encoded = await _encoder.encodeWebp(
        bytes: normalizedBytes,
        quality: quality,
        lossless: false,
      );

      if (smallest == null || encoded.length < smallest.length) {
        smallest = encoded;
      }

      if (encoded.length <= maxBytes) {
        best = encoded;
        low = quality + 1;
      } else {
        high = quality - 1;
      }
    }

    if (best != null) {
      return best;
    }
    throw StateError(
      smallest == null
          ? EditorMessages.webpEncodingFailed
          : EditorMessages.unableToCompressImage(maxBytes),
    );
  }

  Future<void> _writeBytesAtomic(String path, Uint8List bytes) async {
    await Directory(p.dirname(path)).create(recursive: true);
    final temp = File(PackFiles.tempFilePath(path));
    await temp.writeAsBytes(bytes, flush: true);
    if (await File(path).exists()) {
      await File(path).delete();
    }
    await temp.rename(path);
  }

  Future<void> _deleteDirectoryIfExists(String path) async {
    final directory = Directory(path);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
