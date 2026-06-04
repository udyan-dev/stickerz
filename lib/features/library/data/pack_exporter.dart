import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../data/io/library_dirs.dart';
import '../data/io/file_ops.dart';
import '../domain/pack_models.dart';
import '../domain/pack_validator.dart';
import '../util/library_ids.dart';

class PackExporter {
  PackExporter(this._appDirs, this._fileOps, this._validator);

  final LibraryDirs _appDirs;
  final FileOps _fileOps;
  final PackValidator _validator;

  Future<AppResult<String>> export(StickerPack pack) async {
    final validation = await _validator.validatePack(
      pack,
      mode: PackValidationMode.export,
    );
    if (validation.isFailure) {
      return AppResult.failure(validation.errorOrNull!);
    }

    final exportDir = Directory(
      p.join((await _appDirs.temp()).path, PackFiles.exportDirectoryName),
    );
    final archiveName =
        '${LibraryIds.sanitize(pack.name).isEmpty ? pack.id : LibraryIds.sanitize(pack.name)}${PackFiles.archiveExtension}';
    final outputPath = p.join(exportDir.path, archiveName);

    try {
      await _fileOps.ensureDirectory(exportDir.path);
      await cleanupOldExports();
      final bytes = await Isolate.run(
        () => _buildArchive(_ExportInput.fromPack(pack)),
      );
      await _fileOps.writeBytesAtomic(outputPath, bytes);
      return AppResult.success(outputPath);
    } on FileSystemException catch (error) {
      return AppResult.failure(
        AppError.storage(
          message: PackMessages.failedExportPack,
          path: error.path,
          debugDetails: error.toString(),
        ),
      );
    } on Object catch (error) {
      return AppResult.failure(
        AppError.unknown(
          message: PackMessages.failedExportPack,
          debugDetails: error.toString(),
        ),
      );
    }
  }

  Future<void> cleanupOldExports() async {
    final exportDir = Directory(
      p.join((await _appDirs.temp()).path, PackFiles.exportDirectoryName),
    );
    if (!await exportDir.exists()) {
      return;
    }
    final cutoff = DateTime.now().subtract(const Duration(days: 2));
    await for (final entity in exportDir.list(followLinks: false)) {
      if (entity is! File ||
          !entity.path.toLowerCase().endsWith(PackFiles.archiveExtension)) {
        continue;
      }
      final stat = await entity.stat();
      if (stat.modified.isBefore(cutoff)) {
        await entity.delete();
      }
    }
  }
}

Uint8List _buildArchive(_ExportInput input) {
  final archive = Archive();
  final manifest = <String, dynamic>{
    PackJsonKeys.version: 1,
    PackJsonKeys.id: input.id,
    PackJsonKeys.name: input.name,
    PackJsonKeys.publisher: input.publisher,
    PackJsonKeys.tray: PackFiles.trayFileName,
    PackJsonKeys.stickers: input.stickers
        .map(
          (sticker) => <String, dynamic>{
            PackJsonKeys.file: sticker.archivePath,
            PackJsonKeys.emojis: sticker.emojis,
          },
        )
        .toList(growable: false),
  };
  final manifestBytes = utf8.encode(jsonEncode(manifest));
  archive.addFile(
    ArchiveFile(
      PackFiles.manifestFileName,
      manifestBytes.length,
      manifestBytes,
    ),
  );

  final trayBytes = File(input.trayPath).readAsBytesSync();
  archive.addFile(
    ArchiveFile(PackFiles.trayFileName, trayBytes.length, trayBytes),
  );

  for (final sticker in input.stickers) {
    final bytes = File(sticker.sourcePath).readAsBytesSync();
    archive.addFile(ArchiveFile(sticker.archivePath, bytes.length, bytes));
  }

  final encoded = ZipEncoder().encode(archive);
  return Uint8List.fromList(encoded);
}

class _ExportInput {
  const _ExportInput({
    required this.id,
    required this.name,
    required this.publisher,
    required this.trayPath,
    required this.stickers,
  });

  factory _ExportInput.fromPack(StickerPack pack) {
    return _ExportInput(
      id: pack.id,
      name: pack.name,
      publisher: pack.publisher,
      trayPath: pack.trayPath,
      stickers: pack.stickers.indexed
          .map((entry) {
            final index = entry.$1 + 1;
            final sticker = entry.$2;
            return _ExportSticker(
              sourcePath: pack.stickerPath(sticker.file),
              archivePath: PackFiles.archiveStickerPath(index),
              emojis: sticker.emojis,
            );
          })
          .toList(growable: false),
    );
  }

  final String id;
  final String name;
  final String publisher;
  final String trayPath;
  final List<_ExportSticker> stickers;
}

class _ExportSticker {
  const _ExportSticker({
    required this.sourcePath,
    required this.archivePath,
    required this.emojis,
  });

  final String sourcePath;
  final String archivePath;
  final List<String> emojis;
}
