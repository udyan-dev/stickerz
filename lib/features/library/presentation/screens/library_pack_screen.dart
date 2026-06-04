import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/util/constants/constants.dart';
import '../../../editor/data/image_editor.dart';
import '../../../editor/presentation/screens/editor_screen.dart';
import '../../../editor/data/media_source.dart';
import '../../../editor/data/sticker_processor.dart';
import '../../../editor/domain/process_models.dart';
import '../../domain/pack_models.dart';
import '../library_cubit.dart';
import '../library_state.dart';
import '../widgets/local_pack_preview.dart';

enum _PackMenuAction { edit, delete }

enum _TrayMenuAction { edit, replace }

enum _StickerMenuAction { edit, replace, delete }

class LibraryPackScreen extends StatefulWidget {
  const LibraryPackScreen({required this.cubit, this.packId, super.key});

  final LibraryCubit cubit;
  final String? packId;

  @override
  State<LibraryPackScreen> createState() => _LibraryPackScreenState();
}

class _LibraryPackScreenState extends State<LibraryPackScreen> {
  late final MediaSource _mediaSource;
  late final StickerProcessor _stickerProcessor;
  late final TextEditingController _nameController;
  String? _packId;
  bool _submitting = false;
  String? _busyKey;

  @override
  void initState() {
    super.initState();
    _mediaSource = serviceLocator<MediaSource>();
    _stickerProcessor = serviceLocator<StickerProcessor>();
    _nameController = TextEditingController();
    _packId = widget.packId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LibraryState>(
      stream: widget.cubit.stream,
      initialData: widget.cubit.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? widget.cubit.state;
        final pack = _packId == null ? null : _packById(state, _packId!);

        if (_packId == null) {
          return _buildCreatePackScaffold(state);
        }

        if (pack == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(pack.name),
            actions: [
              PopupMenuButton<_PackMenuAction>(
                onSelected: (value) {
                  switch (value) {
                    case _PackMenuAction.edit:
                      _editPack(pack);
                    case _PackMenuAction.delete:
                      _deletePack(pack);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem<_PackMenuAction>(
                    value: _PackMenuAction.edit,
                    child: Text(LibraryUiStrings.editPackAction),
                  ),
                  PopupMenuItem<_PackMenuAction>(
                    value: _PackMenuAction.delete,
                    child: Text(LibraryUiStrings.deletePackAction),
                  ),
                ],
              ),
            ],
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  if (state.error != null)
                    ListTile(
                      leading: const Icon(Icons.info_outline_rounded),
                      title: Text(state.error!.userMessage),
                    ),
                  if (state.invalidPacks.containsKey(pack.id))
                    ListTile(
                      leading: const Icon(Icons.warning_amber_rounded),
                      title: Text(state.invalidPacks[pack.id]!.userMessage),
                    ),
                  ListTile(
                    title: Text(pack.name),
                    subtitle: Text(
                      LibraryUiStrings.packSummary(
                        pack.stickers.length,
                        pack.version,
                      ),
                    ),
                  ),
                  const ListTile(title: Text(LibraryUiStrings.traySection)),
                  Card(
                    child: ListTile(
                      leading: LocalPackPreview(
                        path: pack.trayPath,
                        fallbackIcon: Icons.crop_square_rounded,
                      ),
                      title: Text(
                        pack.tray.isEmpty
                            ? LibraryUiStrings.trayMissing
                            : pack.tray,
                      ),
                      trailing: pack.tray.isEmpty
                          ? TextButton(
                              onPressed: _busyKey == 'tray'
                                  ? null
                                  : () => _replaceTray(pack),
                              child: const Text(LibraryUiStrings.addTrayAction),
                            )
                          : PopupMenuButton<_TrayMenuAction>(
                              onSelected: (value) {
                                switch (value) {
                                  case _TrayMenuAction.edit:
                                    _editTray(pack);
                                  case _TrayMenuAction.replace:
                                    _replaceTray(pack);
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem<_TrayMenuAction>(
                                  value: _TrayMenuAction.edit,
                                  child: Text(LibraryUiStrings.editTrayAction),
                                ),
                                PopupMenuItem<_TrayMenuAction>(
                                  value: _TrayMenuAction.replace,
                                  child: Text(
                                    LibraryUiStrings.replaceTrayAction,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const ListTile(title: Text(LibraryUiStrings.stickersSection)),
                  if (pack.stickers.isEmpty)
                    const ListTile(title: Text(LibraryUiStrings.stickersEmpty)),
                  ListTile(
                    title: FilledButton.icon(
                      onPressed: _busyKey == 'addSticker'
                          ? null
                          : () => _addSticker(pack),
                      icon: const Icon(Icons.add_photo_alternate_rounded),
                      label: const Text(LibraryUiStrings.addStickerAction),
                    ),
                  ),
                  for (final sticker in pack.stickers)
                    Card(
                      child: ListTile(
                        leading: LocalPackPreview(
                          path: pack.stickerPath(sticker.file),
                          fallbackIcon: Icons.sticky_note_2_rounded,
                        ),
                        title: Text(sticker.file),
                        subtitle: sticker.emojis.isEmpty
                            ? null
                            : Text(sticker.emojis.join(' ')),
                        trailing: PopupMenuButton<_StickerMenuAction>(
                          onSelected: (value) {
                            switch (value) {
                              case _StickerMenuAction.edit:
                                _editSticker(pack, sticker);
                              case _StickerMenuAction.replace:
                                _replaceSticker(pack, sticker);
                              case _StickerMenuAction.delete:
                                _deleteSticker(pack, sticker);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem<_StickerMenuAction>(
                              value: _StickerMenuAction.edit,
                              child: Text(LibraryUiStrings.editStickerAction),
                            ),
                            PopupMenuItem<_StickerMenuAction>(
                              value: _StickerMenuAction.replace,
                              child: Text(
                                LibraryUiStrings.replaceStickerAction,
                              ),
                            ),
                            PopupMenuItem<_StickerMenuAction>(
                              value: _StickerMenuAction.delete,
                              child: Text(LibraryUiStrings.deleteStickerAction),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (_busyKey != null)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }

  Scaffold _buildCreatePackScaffold(LibraryState state) {
    return Scaffold(
      appBar: AppBar(title: const Text(LibraryUiStrings.createPackTitle)),
      body: ListView(
        children: [
          const ListTile(title: Text(LibraryUiStrings.createPackPrompt)),
          ListTile(
            title: TextField(
              controller: _nameController,
              enabled: !_submitting,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _createPack(),
              decoration: const InputDecoration(
                labelText: LibraryUiStrings.packNameLabel,
              ),
            ),
          ),
          if (state.error != null)
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(state.error!.userMessage),
            ),
          ListTile(
            title: FilledButton(
              onPressed: _submitting ? null : _createPack,
              child: const Text(LibraryUiStrings.continueAction),
            ),
          ),
        ],
      ),
    );
  }

  StickerPack? _packById(LibraryState state, String packId) {
    for (final pack in state.packs) {
      if (pack.id == packId) {
        return pack;
      }
    }
    return null;
  }

  Future<void> _createPack() async {
    final name = _nameController.text.trim();
    if (name.isEmpty || _submitting) {
      return;
    }

    final existingIds = widget.cubit.state.packs.map((pack) => pack.id).toSet();
    setState(() {
      _submitting = true;
    });
    await widget.cubit.createPack(name: name, publisher: AppUiStrings.appTitle);
    if (!mounted) {
      return;
    }
    setState(() {
      _submitting = false;
    });

    if (widget.cubit.state.error != null) {
      return;
    }

    for (final pack in widget.cubit.state.packs) {
      if (!existingIds.contains(pack.id)) {
        setState(() {
          _packId = pack.id;
        });
        return;
      }
    }
  }

  Future<void> _editPack(StickerPack pack) async {
    final controller = TextEditingController(text: pack.name);
    final nextName = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(LibraryUiStrings.editPackTitle),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: LibraryUiStrings.packNameLabel,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(LibraryUiStrings.cancelAction),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text(LibraryUiStrings.saveAction),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (nextName == null || nextName.isEmpty || nextName == pack.name) {
      return;
    }

    await _runBusy('editPack', () async {
      await widget.cubit.updatePackMetadata(
        packId: pack.id,
        name: nextName,
        publisher: pack.publisher,
      );
      _showCubitError();
    });
  }

  Future<void> _deletePack(StickerPack pack) async {
    final confirmed = await _confirm(
      title: LibraryUiStrings.deletePackTitle,
      message: LibraryUiStrings.deletePackMessage(pack.name),
    );
    if (!confirmed) {
      return;
    }

    await _runBusy('deletePack', () async {
      await widget.cubit.deletePack(pack.id);
      if (!mounted) {
        return;
      }
      if (widget.cubit.state.error != null) {
        _showCubitError();
        return;
      }
      Navigator.of(context).pop();
    });
  }

  Future<void> _editTray(StickerPack pack) {
    return _runBusy('editTray', () async {
      final editableSession = await _loadEditableSession(
        pack: pack,
        targetFileName: PackFiles.trayFileName,
        fallbackSourcePath: pack.trayPath,
      );
      final processed = await _processImage(
        outputType: ProcessOutputType.tray,
        pack: pack,
        sourcePath: editableSession.sourcePath,
        initialStateJson: editableSession.initialStateJson,
      );
      if (processed == null) {
        return;
      }
      await widget.cubit.setProcessedTray(
        packId: pack.id,
        result: processed.result,
        editableSourcePath: processed.sourcePath,
        editStateJson: processed.editStateJson,
      );
      _showCubitError();
    });
  }

  Future<void> _replaceTray(StickerPack pack) {
    return _runBusy('tray', () async {
      final processed = await _processImage(
        outputType: ProcessOutputType.tray,
        pack: pack,
      );
      if (processed == null) {
        return;
      }
      await widget.cubit.setProcessedTray(
        packId: pack.id,
        result: processed.result,
        editableSourcePath: processed.sourcePath,
        editStateJson: processed.editStateJson,
      );
      _showCubitError();
    });
  }

  Future<void> _addSticker(StickerPack pack) {
    return _runBusy('addSticker', () async {
      final processed = await _processImage(
        outputType: ProcessOutputType.sticker,
        pack: pack,
        stickerIndex: pack.stickers.length,
      );
      if (processed == null) {
        return;
      }
      await widget.cubit.addProcessedSticker(
        packId: pack.id,
        result: processed.result,
        editableSourcePath: processed.sourcePath,
        editStateJson: processed.editStateJson,
      );
      _showCubitError();
    });
  }

  Future<void> _editSticker(StickerPack pack, StickerItem sticker) {
    return _runBusy('edit:${sticker.file}', () async {
      final editableSession = await _loadEditableSession(
        pack: pack,
        targetFileName: sticker.file,
        fallbackSourcePath: pack.stickerPath(sticker.file),
      );
      final processed = await _processImage(
        outputType: ProcessOutputType.sticker,
        pack: pack,
        sourcePath: editableSession.sourcePath,
        initialStateJson: editableSession.initialStateJson,
      );
      if (processed == null) {
        return;
      }
      await widget.cubit.replaceProcessedSticker(
        packId: pack.id,
        fileName: sticker.file,
        result: processed.result,
        editableSourcePath: processed.sourcePath,
        editStateJson: processed.editStateJson,
      );
      _showCubitError();
    });
  }

  Future<void> _replaceSticker(StickerPack pack, StickerItem sticker) {
    return _runBusy('replace:${sticker.file}', () async {
      final processed = await _processImage(
        outputType: ProcessOutputType.sticker,
        pack: pack,
      );
      if (processed == null) {
        return;
      }
      await widget.cubit.replaceProcessedSticker(
        packId: pack.id,
        fileName: sticker.file,
        result: processed.result,
        editableSourcePath: processed.sourcePath,
        editStateJson: processed.editStateJson,
      );
      _showCubitError();
    });
  }

  Future<void> _deleteSticker(StickerPack pack, StickerItem sticker) async {
    final confirmed = await _confirm(
      title: LibraryUiStrings.deleteStickerTitle,
      message: LibraryUiStrings.deleteStickerMessage(sticker.file),
    );
    if (!confirmed) {
      return;
    }

    await _runBusy('delete:${sticker.file}', () async {
      await widget.cubit.removeSticker(packId: pack.id, fileName: sticker.file);
      _showCubitError();
    });
  }

  Future<_ProcessedEdit?> _processImage({
    required ProcessOutputType outputType,
    required StickerPack pack,
    int? stickerIndex,
    String? sourcePath,
    String? initialStateJson,
  }) async {
    var editorSourcePath = sourcePath;
    if (editorSourcePath == null || editorSourcePath.isEmpty) {
      final picked = await _mediaSource.pickImage();
      final pickedError = picked.errorOrNull;
      if (pickedError != null) {
        if (pickedError.type != AppErrorType.cancelled) {
          _showError(pickedError);
        }
        return null;
      }

      editorSourcePath = picked.valueOrNull;
      if (editorSourcePath == null || editorSourcePath.isEmpty) {
        return null;
      }
    }

    if (!mounted) {
      return null;
    }

    final editResult = await Navigator.of(context).push<ImageEditResult>(
      MaterialPageRoute<ImageEditResult>(
        builder: (_) => EditorScreen(
          sourcePath: editorSourcePath!,
          initialStateJson: initialStateJson,
        ),
      ),
    );
    if (!mounted || editResult == null || editResult.bytes.isEmpty) {
      return null;
    }

    final processed = await _stickerProcessor.process(
      ProcessRequest(
        sourceBytes: editResult.bytes,
        outputType: outputType,
        targetSize: outputType == ProcessOutputType.tray
            ? PackRules.traySize
            : PackRules.stickerSize,
        maxBytes: outputType == ProcessOutputType.tray
            ? PackRules.trayMaxBytes
            : pack.animated
            ? PackRules.animatedStickerMaxBytes
            : PackRules.staticStickerMaxBytes,
        stickerIndex: stickerIndex,
      ),
    );
    final processedError = processed.errorOrNull;
    if (processedError != null) {
      _showError(processedError);
      return null;
    }

    return _ProcessedEdit(
      result: processed.valueOrNull!,
      sourcePath: editorSourcePath,
      editStateJson: editResult.stateHistoryJson,
    );
  }

  Future<_EditableSession> _loadEditableSession({
    required StickerPack pack,
    required String targetFileName,
    required String fallbackSourcePath,
  }) async {
    final storedSourcePath = await _resolveEditableSourcePath(
      folderPath: pack.folderPath,
      targetFileName: targetFileName,
    );
    if (storedSourcePath == null) {
      return _EditableSession(sourcePath: fallbackSourcePath);
    }

    return _EditableSession(
      sourcePath: storedSourcePath,
      initialStateJson: await _readOptionalFile(
        p.join(pack.folderPath, PackFiles.editStateFileName(targetFileName)),
      ),
    );
  }

  Future<String?> _resolveEditableSourcePath({
    required String folderPath,
    required String targetFileName,
  }) async {
    final directory = Directory(folderPath);
    if (!await directory.exists()) {
      return null;
    }

    final sourcePrefix = '${PackFiles.editableSourcePrefix(targetFileName)}.';
    await for (final entity in directory.list(followLinks: false)) {
      if (entity is! File) {
        continue;
      }
      final name = p.basename(entity.path);
      if (name.startsWith(sourcePrefix)) {
        return entity.path;
      }
    }
    return null;
  }

  Future<String?> _readOptionalFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      return null;
    }
    try {
      final contents = await file.readAsString();
      return contents.isEmpty ? null : contents;
    } on Object {
      return null;
    }
  }

  Future<void> _runBusy(String key, Future<void> Function() action) async {
    if (_busyKey != null) {
      return;
    }
    setState(() {
      _busyKey = key;
    });
    try {
      await action();
    } finally {
      if (mounted) {
        setState(() {
          _busyKey = null;
        });
      }
    }
  }

  Future<bool> _confirm({
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(LibraryUiStrings.cancelAction),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(LibraryUiStrings.deleteStickerAction),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  void _showCubitError() {
    final error = widget.cubit.state.error;
    if (error != null) {
      _showError(error);
    }
  }

  void _showError(AppError error) {
    if (!mounted || error.type == AppErrorType.cancelled) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(error.userMessage)));
  }
}

class _EditableSession {
  const _EditableSession({required this.sourcePath, this.initialStateJson});

  final String sourcePath;
  final String? initialStateJson;
}

class _ProcessedEdit {
  const _ProcessedEdit({
    required this.result,
    required this.sourcePath,
    this.editStateJson,
  });

  final ProcessResult result;
  final String sourcePath;
  final String? editStateJson;
}
