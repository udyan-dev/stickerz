import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import '../../util/library_ids.dart';

class FileOps {
  Future<void> ensureDirectory(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<void> ensureParentDirectory(String path) {
    return ensureDirectory(p.dirname(path));
  }

  Future<bool> fileExists(String path) => File(path).exists();

  Future<List<Directory>> listDirectories(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      return const <Directory>[];
    }
    return directory
        .list(followLinks: false)
        .where((entity) => entity is Directory)
        .cast<Directory>()
        .toList();
  }

  Future<void> writeBytesAtomic(String path, Uint8List bytes) async {
    await ensureParentDirectory(path);
    final temp = File('$path.${LibraryIds.newOperationId()}.tmp');
    await temp.writeAsBytes(bytes, flush: true);
    await _replaceFile(temp, File(path));
  }

  Future<void> writeStringAtomic(String path, String contents) async {
    await ensureParentDirectory(path);
    final temp = File('$path.${LibraryIds.newOperationId()}.tmp');
    await temp.writeAsString(contents, flush: true);
    await _replaceFile(temp, File(path));
  }

  Future<void> moveFile(
    String sourcePath,
    String destinationPath, {
    bool replace = false,
  }) async {
    await ensureParentDirectory(destinationPath);
    final source = File(sourcePath);
    final destination = File(destinationPath);
    if (replace && await destination.exists()) {
      await destination.delete();
    }
    try {
      await source.rename(destination.path);
    } on FileSystemException {
      await source.copy(destination.path);
      await source.delete();
    }
  }

  Future<void> copyFile(String sourcePath, String destinationPath) async {
    await ensureParentDirectory(destinationPath);
    await File(sourcePath).copy(destinationPath);
  }

  Future<void> deleteFileIfExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> deleteDirectoryIfExists(String path) async {
    final directory = Directory(path);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }

  Future<void> replaceDirectory(
    String sourcePath,
    String destinationPath,
  ) async {
    await ensureParentDirectory(destinationPath);
    final source = Directory(sourcePath);
    final destination = Directory(destinationPath);
    final backup = Directory(
      '$destinationPath.${LibraryIds.newOperationId()}.bak',
    );
    if (await destination.exists()) {
      await destination.rename(backup.path);
    }
    try {
      await source.rename(destinationPath);
      if (await backup.exists()) {
        await backup.delete(recursive: true);
      }
    } catch (_) {
      if (!await destination.exists() && await backup.exists()) {
        await backup.rename(destinationPath);
      }
      rethrow;
    }
  }

  Future<void> _replaceFile(File source, File destination) async {
    if (await destination.exists()) {
      await destination.delete();
    }
    try {
      await source.rename(destination.path);
    } on FileSystemException {
      await source.copy(destination.path);
      await source.delete();
    }
  }
}
