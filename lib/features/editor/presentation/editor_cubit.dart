import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/error/app_error.dart';
import '../../../core/util/constants/constants.dart';
import '../data/media_source.dart';
import '../data/sticker_processor.dart';
import '../domain/process_models.dart';
import 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit(this._mediaSource, this._stickerProcessor)
    : super(const EditorState());

  final MediaSource _mediaSource;
  final StickerProcessor _stickerProcessor;

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    final result = await _mediaSource.pickImage(source: source);
    emit(
      state.copyWith(
        pickedImagePath: result.valueOrNull,
        error: result.errorOrNull,
      ),
    );
  }

  Future<void> process(ProcessRequest request) async {
    emit(state.copyWith(processing: true, error: null));
    final result = await _stickerProcessor.process(request);
    emit(
      state.copyWith(
        processing: false,
        lastStickerResult: request.outputType == ProcessOutputType.sticker
            ? result.valueOrNull
            : state.lastStickerResult,
        lastTrayResult: request.outputType == ProcessOutputType.tray
            ? result.valueOrNull
            : state.lastTrayResult,
        error: result.errorOrNull,
      ),
    );
  }

  Future<void> processSticker({
    String? sourcePath,
    Uint8List? sourceBytes,
    required int targetSize,
    required int maxBytes,
    int? stickerIndex,
    CropPolicy cropPolicy = CropPolicy.cover,
    bool transparentBackgroundPreferred = true,
  }) {
    if (sourcePath == null && sourceBytes == null) {
      emit(
        state.copyWith(
          error: const AppError.validation(
            message: EditorMessages.noSourceImage,
          ),
        ),
      );
      return Future<void>.value();
    }
    return process(
      ProcessRequest(
        sourcePath: sourcePath,
        sourceBytes: sourceBytes,
        outputType: ProcessOutputType.sticker,
        targetSize: targetSize,
        maxBytes: maxBytes,
        stickerIndex: stickerIndex,
        cropPolicy: cropPolicy,
        transparentBackgroundPreferred: transparentBackgroundPreferred,
      ),
    );
  }

  Future<void> processTray({
    String? sourcePath,
    Uint8List? sourceBytes,
    required int targetSize,
    required int maxBytes,
    CropPolicy cropPolicy = CropPolicy.cover,
    bool transparentBackgroundPreferred = true,
  }) {
    if (sourcePath == null && sourceBytes == null) {
      emit(
        state.copyWith(
          error: const AppError.validation(
            message: EditorMessages.noSourceImage,
          ),
        ),
      );
      return Future<void>.value();
    }
    return process(
      ProcessRequest(
        sourcePath: sourcePath,
        sourceBytes: sourceBytes,
        outputType: ProcessOutputType.tray,
        targetSize: targetSize,
        maxBytes: maxBytes,
        cropPolicy: cropPolicy,
        transparentBackgroundPreferred: transparentBackgroundPreferred,
      ),
    );
  }

  void clearStickerResult() {
    if (state.lastStickerResult == null) {
      return;
    }
    emit(state.copyWith(lastStickerResult: null));
  }

  void clearTrayResult() {
    if (state.lastTrayResult == null) {
      return;
    }
    emit(state.copyWith(lastTrayResult: null));
  }

  void clearError() {
    if (state.error == null) {
      return;
    }
    emit(state.copyWith(error: null));
  }
}
