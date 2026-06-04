import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../data/image_editor.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({
    required this.sourcePath,
    this.initialStateJson,
    super.key,
  });

  final String sourcePath;
  final String? initialStateJson;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final ImageEditor _imageEditor;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _imageEditor = serviceLocator<ImageEditor>();
  }

  @override
  Widget build(BuildContext context) {
    return _imageEditor.buildFromFile(
      path: widget.sourcePath,
      initialStateJson: widget.initialStateJson,
      onComplete: _handleComplete,
      onClose: _handleClose,
    );
  }

  Future<void> _handleComplete(ImageEditResult result) async {
    if (!mounted || _completed) {
      return;
    }
    _completed = true;
    Navigator.of(context).pop(result);
  }

  void _handleClose() {
    if (!mounted || _completed) {
      return;
    }
    _completed = true;
    Navigator.of(context).pop();
  }
}
