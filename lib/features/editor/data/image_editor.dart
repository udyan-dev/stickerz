import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../../../core/theme/app_theme.dart';

typedef ImageEditComplete = Future<void> Function(ImageEditResult result);

class ImageEditResult {
  const ImageEditResult({required this.bytes, this.stateHistoryJson});

  final Uint8List bytes;
  final String? stateHistoryJson;
}

abstract interface class ImageEditor {
  Widget buildFromBytes({
    required Uint8List bytes,
    String? initialStateJson,
    required ImageEditComplete onComplete,
    VoidCallback? onClose,
  });

  Widget buildFromFile({
    required String path,
    String? initialStateJson,
    required ImageEditComplete onComplete,
    VoidCallback? onClose,
  });
}

class ProImageEditorAdapter implements ImageEditor {
  const ProImageEditorAdapter();

  static const ImageGenerationConfigs _imageGenerationConfigs =
      ImageGenerationConfigs(
        outputFormat: OutputFormat.png,
        captureImageByteFormat: ui.ImageByteFormat.rawStraightRgba,
        jpegQuality: 100,
        pngLevel: 6,
        enableIsolateGeneration: true,
        enableBackgroundGeneration: true,
      );

  @override
  Widget buildFromBytes({
    required Uint8List bytes,
    String? initialStateJson,
    required ImageEditComplete onComplete,
    VoidCallback? onClose,
  }) {
    final editorKey = GlobalKey<ProImageEditorState>();
    return ProImageEditor.memory(
      bytes,
      key: editorKey,
      configs: _buildConfigs(initialStateJson),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (editedBytes) =>
            _handleComplete(editorKey, editedBytes, onComplete),
        onCloseEditor: (_) => onClose?.call(),
      ),
    );
  }

  @override
  Widget buildFromFile({
    required String path,
    String? initialStateJson,
    required ImageEditComplete onComplete,
    VoidCallback? onClose,
  }) {
    final editorKey = GlobalKey<ProImageEditorState>();
    return ProImageEditor.file(
      path,
      key: editorKey,
      configs: _buildConfigs(initialStateJson),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (editedBytes) =>
            _handleComplete(editorKey, editedBytes, onComplete),
        onCloseEditor: (_) => onClose?.call(),
      ),
    );
  }

  Future<void> _handleComplete(
    GlobalKey<ProImageEditorState> editorKey,
    Uint8List editedBytes,
    ImageEditComplete onComplete,
  ) async {
    String? stateHistoryJson;
    final editor = editorKey.currentState;
    if (editor != null) {
      try {
        final history = await editor.exportStateHistory(
          configs: const ExportEditorConfigs(
            historySpan: ExportHistorySpan.current,
          ),
        );
        stateHistoryJson = await history.toJson();
      } on Object {
        stateHistoryJson = null;
      }
    }

    await onComplete(
      ImageEditResult(bytes: editedBytes, stateHistoryJson: stateHistoryJson),
    );
  }

  ProImageEditorConfigs _buildConfigs(String? initialStateJson) {
    final initStateHistory = _buildInitialStateHistory(initialStateJson);
    return ProImageEditorConfigs(
      // WhatsApp keeps its media editor dark in both app themes.
      theme: AppTheme.dark,
      imageGeneration: _imageGenerationConfigs,
      stateHistory: StateHistoryConfigs(initStateHistory: initStateHistory),
    );
  }

  ImportStateHistory? _buildInitialStateHistory(String? initialStateJson) {
    if (initialStateJson == null || initialStateJson.isEmpty) {
      return null;
    }

    try {
      return ImportStateHistory.fromJson(
        initialStateJson,
        configs: const ImportEditorConfigs(recalculateSizeAndPosition: true),
      );
    } on Object {
      return null;
    }
  }
}
