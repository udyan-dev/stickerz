import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/app_error.dart';
import '../domain/process_models.dart';

part 'editor_state.freezed.dart';

@freezed
abstract class EditorState with _$EditorState {
  const factory EditorState({
    @Default(false) bool processing,
    String? pickedImagePath,
    ProcessResult? lastStickerResult,
    ProcessResult? lastTrayResult,
    AppError? error,
  }) = _EditorState;
}
