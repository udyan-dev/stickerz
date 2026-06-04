import 'dart:io';

import 'package:path/path.dart' as p;

import '../../../../core/util/constants/constants.dart';

class LibraryDirs {
  LibraryDirs(this._packsRoot);

  final Future<Directory> Function() _packsRoot;
  Future<Directory>? _packsFuture;
  Future<Directory>? _tempFuture;

  Future<Directory> packs() {
    return _packsFuture ??= _ensureDirectoryFromDirectory(_packsRoot());
  }

  Future<Directory> temp() async {
    final packsDir = await packs();
    return _tempFuture ??= _ensureDirectory(
      p.join(packsDir.parent.path, PackFiles.tempDirectoryName),
    );
  }

  Future<Directory> pack(String packId) async {
    return _ensureDirectory(p.join((await packs()).path, packId));
  }

  Future<Directory> operation(String operationId) async {
    return _ensureDirectory(p.join((await temp()).path, operationId));
  }

  Future<Directory> _ensureDirectoryFromDirectory(
    Future<Directory> directory,
  ) async {
    final resolved = await directory;
    return _ensureDirectory(resolved.path);
  }

  Future<Directory> _ensureDirectory(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }
}
