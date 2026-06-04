import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../whatsapp/data/whatsapp_channel.dart';
import '../data/io/library_dirs.dart';
import '../data/io/file_ops.dart';
import '../domain/pack_models.dart';
import '../util/library_ids.dart';
import 'pack_store.dart';

class PackImporter {
  PackImporter(this._appDirs, this._fileOps, this._packStore, this._channel);

  final LibraryDirs _appDirs;
  final FileOps _fileOps;
  final PackStore _packStore;
  final WhatsAppChannel _channel;

  Future<AppResult<StickerPack>> importFromUri(String source) async {
    final operationDir = await _appDirs.operation(LibraryIds.newOperationId());
    try {
      final archivePath = await _copySource(source, operationDir.path);
      if (archivePath == null) {
        return const AppResult.failure(AppError.cancelled());
      }
      final archiveSize = await File(archivePath).length();
      final maxArchiveBytes =
          PackRules.maxZipEntries * PackRules.maxZipAssetBytes +
          PackRules.manifestMaxBytes;
      if (archiveSize <= 0 || archiveSize > maxArchiveBytes) {
        return const AppResult.failure(
          AppError.invalidPack(message: PackMessages.archiveCorrupted),
        );
      }
      final extractedPath = p.join(
        operationDir.path,
        PackFiles.extractedPackDirectoryName,
      );
      final extraction = await Isolate.run(
        () => _extractWspack(
          archivePath: archivePath,
          destinationPath: extractedPath,
        ),
      );
      if (extraction['ok'] != true) {
        return AppResult.failure(_errorFromCode(extraction));
      }
      return await _packStore.installImportedPack(
        extractedDirPath: extractedPath,
      );
    } finally {
      await _fileOps.deleteDirectoryIfExists(operationDir.path);
    }
  }

  Future<AppResult<StickerPack>?> importPendingIntent() async {
    final source = await takePendingSource();
    if (source == null || source.isEmpty) {
      return null;
    }
    return importFromUri(source);
  }

  Future<String?> takePendingSource() {
    return _channel.takeIncomingPack();
  }

  Future<String?> _copySource(String source, String operationPath) async {
    final uri = Uri.tryParse(source);
    if (uri != null && uri.scheme == UriSchemes.content) {
      return _channel.copyImportUri(source);
    }

    final sourcePath = uri != null && uri.scheme == UriSchemes.file
        ? uri.toFilePath()
        : source;
    final file = File(sourcePath);
    if (!await file.exists()) {
      return null;
    }
    final destinationPath = p.join(
      operationPath,
      PackFiles.sourceArchiveFileName,
    );
    await _fileOps.copyFile(file.path, destinationPath);
    return destinationPath;
  }
}

Map<String, Object?> _extractWspack({
  required String archivePath,
  required String destinationPath,
}) {
  try {
    Directory(destinationPath).createSync(recursive: true);
    final archive = ZipDecoder().decodeBytes(
      File(archivePath).readAsBytesSync(),
    );
    final files = archive.files.where((entry) => entry.isFile).toList();
    if (files.length > PackRules.maxZipEntries) {
      return _failure(PackCodes.invalidPack, PackMessages.archiveTooManyFiles);
    }

    final seen = <String>{};
    ArchiveFile? manifestEntry;
    ArchiveFile? trayEntry;
    final stickerEntries = <String, ArchiveFile>{};
    var totalBytes = 0;

    for (final entry in files) {
      if (entry.isSymbolicLink) {
        return _failure(
          PackCodes.unsafeArchivePath,
          PackMessages.archiveUnsafePaths,
        );
      }
      final name = _safeArchivePath(entry.name);
      if (name == null || !seen.add(name)) {
        return _failure(
          PackCodes.unsafeArchivePath,
          PackMessages.archiveUnsafePaths,
        );
      }
      totalBytes += entry.size;
      if (totalBytes > PackRules.maxZipEntries * PackRules.maxZipAssetBytes) {
        return _failure(
          PackCodes.invalidPack,
          PackMessages.archiveFilesTooLarge,
        );
      }

      if (name == PackFiles.manifestFileName) {
        if (entry.size <= 0 || entry.size > PackRules.manifestMaxBytes) {
          return _failure(
            PackCodes.malformedManifest,
            PackMessages.manifestInvalid,
          );
        }
        manifestEntry = entry;
      } else if (name == PackFiles.trayFileName) {
        if (entry.size <= 0 || entry.size > PackRules.trayMaxBytes) {
          return _failure(PackCodes.invalidTray, PackMessages.trayInvalid);
        }
        trayEntry = entry;
      } else if (name.startsWith('${PackFiles.stickersDirectoryName}/') &&
          name.endsWith(PackFiles.webpExtension)) {
        if (entry.size <= 0 || entry.size > PackRules.maxZipAssetBytes) {
          return _failure(
            PackCodes.invalidSticker,
            PackMessages.stickerInvalid,
          );
        }
        stickerEntries[name] = entry;
      } else {
        return _failure(
          PackCodes.unsafeArchivePath,
          PackMessages.archiveUnsupportedFiles,
        );
      }
    }

    if (manifestEntry == null) {
      return _failure(PackCodes.missingManifest, PackMessages.manifestMissing);
    }
    final manifest = _readManifest(manifestEntry);
    if (manifest == null) {
      return _failure(
        PackCodes.malformedManifest,
        PackMessages.manifestInvalid,
      );
    }
    if (manifest.version != 1) {
      return _failure(
        PackCodes.unsupportedVersion,
        PackMessages.versionUnsupported,
      );
    }
    if (manifest.tray != PackFiles.trayFileName) {
      return _failure(PackCodes.missingTray, PackMessages.trayMissingFromPack);
    }
    if (trayEntry == null) {
      return _failure(PackCodes.missingTray, PackMessages.trayMissingFromPack);
    }
    final checkedTrayEntry = trayEntry;
    if (manifest.stickers.length < PackRules.minStickers ||
        manifest.stickers.length > PackRules.maxStickers) {
      return _failure(PackCodes.invalidPack, PackMessages.stickerCountRange);
    }

    _writeEntry(
      checkedTrayEntry,
      p.join(destinationPath, PackFiles.trayFileName),
    );
    final stickers = <Map<String, Object?>>[];
    for (final entry in manifest.stickers.indexed) {
      final sourceSticker = entry.$2;
      final archiveEntry = stickerEntries[sourceSticker.file];
      if (archiveEntry == null) {
        return _failure(
          PackCodes.missingSticker,
          PackMessages.stickerMissingFromPack,
        );
      }
      final fileName = PackFiles.stickerFileName(entry.$1 + 1);
      _writeEntry(archiveEntry, p.join(destinationPath, fileName));
      stickers.add(<String, Object?>{
        PackJsonKeys.file: fileName,
        PackJsonKeys.emojis: sourceSticker.emojis,
      });
    }

    final localManifest = <String, Object?>{
      PackJsonKeys.id: LibraryIds.sanitize(manifest.id).isEmpty
          ? LibraryIds.newPackId(manifest.name)
          : LibraryIds.sanitize(manifest.id),
      PackJsonKeys.name: manifest.name,
      PackJsonKeys.publisher: manifest.publisher,
      PackJsonKeys.animated: false,
      PackJsonKeys.tray: PackFiles.trayFileName,
      PackJsonKeys.source: PackSource.custom.name,
      PackJsonKeys.version: 1,
      PackJsonKeys.stickers: stickers,
    };
    File(p.join(destinationPath, PackFiles.manifestFileName)).writeAsStringSync(
      '${jsonEncode(localManifest)}${PackFiles.newline}',
      flush: true,
    );

    return <String, Object?>{PackJsonKeys.ok: true};
  } on ArchiveException catch (error) {
    return _failure(
      PackCodes.corruptedArchive,
      PackMessages.archiveCorrupted,
      error.toString(),
    );
  } on FormatException catch (error) {
    return _failure(
      PackCodes.malformedManifest,
      PackMessages.manifestInvalid,
      error.toString(),
    );
  } on FileSystemException catch (error) {
    return _failure(
      PackCodes.storageFailed,
      PackMessages.packCouldNotBeImported,
      error.toString(),
    );
  } on Object catch (error) {
    return _failure(
      PackCodes.unknown,
      PackMessages.packCouldNotBeImported,
      error.toString(),
    );
  }
}

_ArchiveManifest? _readManifest(ArchiveFile entry) {
  final bytes = _entryBytes(entry);
  final decoded = jsonDecode(utf8.decode(bytes));
  if (decoded is! Map<String, dynamic>) {
    return null;
  }
  final version = (decoded[PackJsonKeys.version] as num?)?.toInt();
  final id = decoded[PackJsonKeys.id];
  final name = decoded[PackJsonKeys.name];
  final publisher = decoded[PackJsonKeys.publisher];
  final tray = decoded[PackJsonKeys.tray];
  final stickers = decoded[PackJsonKeys.stickers];
  if (version == null ||
      id is! String ||
      id.trim().isEmpty ||
      name is! String ||
      name.trim().isEmpty ||
      publisher is! String ||
      publisher.trim().isEmpty ||
      tray is! String ||
      stickers is! List) {
    return null;
  }
  final parsedStickers = <_ArchiveSticker>[];
  for (final item in stickers) {
    if (item is! Map<String, dynamic>) {
      return null;
    }
    final file = item[PackJsonKeys.file];
    final emojis = item[PackJsonKeys.emojis];
    if (file is! String || _safeArchivePath(file) != file) {
      return null;
    }
    if (!file.startsWith('${PackFiles.stickersDirectoryName}/') ||
        !file.endsWith(PackFiles.webpExtension)) {
      return null;
    }
    if (emojis is! List) {
      return null;
    }
    parsedStickers.add(
      _ArchiveSticker(
        file: file,
        emojis: emojis
            .whereType<String>()
            .map((emoji) => emoji.trim())
            .where((emoji) => emoji.isNotEmpty)
            .take(3)
            .toList(growable: false),
      ),
    );
  }
  return _ArchiveManifest(
    version: version,
    id: id.trim(),
    name: name.trim(),
    publisher: publisher.trim(),
    tray: tray.trim(),
    stickers: parsedStickers,
  );
}

String? _safeArchivePath(String raw) {
  final decoded = Uri.decodeFull(raw.trim()).replaceAll(r'\', '/');
  final normalized = p.posix.normalize(decoded);
  if (normalized.isEmpty ||
      normalized == '.' ||
      normalized.startsWith('/') ||
      normalized.startsWith('../') ||
      normalized.contains('/../') ||
      normalized.contains('..') ||
      normalized.startsWith('.')) {
    return null;
  }
  if (normalized != PackFiles.manifestFileName &&
      normalized != PackFiles.trayFileName &&
      !RegExp(PackPatterns.archiveStickerPath).hasMatch(normalized)) {
    return null;
  }
  return normalized;
}

void _writeEntry(ArchiveFile entry, String outputPath) {
  Directory(p.dirname(outputPath)).createSync(recursive: true);
  final output = OutputFileStream(outputPath);
  entry.writeContent(output);
  output.closeSync();
}

Uint8List _entryBytes(ArchiveFile entry) {
  final output = OutputMemoryStream(size: entry.size);
  entry.writeContent(output);
  final bytes = output.getBytes();
  output.closeSync();
  return bytes;
}

Map<String, Object?> _failure(
  String code,
  String message, [
  String? debugDetails,
]) {
  final failure = <String, Object?>{
    PackJsonKeys.ok: false,
    PackJsonKeys.code: code,
    PackJsonKeys.message: message,
  };
  if (debugDetails != null) {
    failure[PackJsonKeys.debugDetails] = debugDetails;
  }
  return failure;
}

AppError _errorFromCode(Map<String, Object?> data) {
  final code = data[PackJsonKeys.code]?.toString();
  final message =
      data[PackJsonKeys.message]?.toString() ??
      PackMessages.packCouldNotBeImported;
  final debugDetails = data[PackJsonKeys.debugDetails]?.toString();
  return switch (code) {
    PackCodes.unsupportedVersion => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.unsupportedVersion],
      debugDetails: debugDetails,
    ),
    PackCodes.missingManifest => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.missingManifest],
      debugDetails: debugDetails,
    ),
    PackCodes.malformedManifest => AppError.parse(
      message: message,
      debugDetails: debugDetails,
    ),
    PackCodes.unsafeArchivePath => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.unsafeArchivePath],
      debugDetails: debugDetails,
    ),
    PackCodes.missingTray => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.missingTray],
      debugDetails: debugDetails,
    ),
    PackCodes.missingSticker => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.missingSticker],
      debugDetails: debugDetails,
    ),
    PackCodes.invalidSticker => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.invalidSticker],
      debugDetails: debugDetails,
    ),
    PackCodes.invalidTray => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.invalidTray],
      debugDetails: debugDetails,
    ),
    PackCodes.corruptedArchive => AppError.invalidPack(
      message: message,
      reasons: const <String>[PackCodes.corruptedArchive],
      debugDetails: debugDetails,
    ),
    PackCodes.storageFailed => AppError.storage(
      message: message,
      debugDetails: debugDetails,
    ),
    _ => AppError.unknown(message: message, debugDetails: debugDetails),
  };
}

class _ArchiveManifest {
  const _ArchiveManifest({
    required this.version,
    required this.id,
    required this.name,
    required this.publisher,
    required this.tray,
    required this.stickers,
  });

  final int version;
  final String id;
  final String name;
  final String publisher;
  final String tray;
  final List<_ArchiveSticker> stickers;
}

class _ArchiveSticker {
  const _ArchiveSticker({required this.file, required this.emojis});

  final String file;
  final List<String> emojis;
}
