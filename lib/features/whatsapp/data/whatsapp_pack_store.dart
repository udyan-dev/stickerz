import 'dart:convert';
import 'dart:io';

import '../../../core/util/constants/constants.dart';
import '../domain/models/whatsapp_pack/whatsapp_pack.dart';
import 'whatsapp_channel.dart';
import 'whatsapp_pack_manifest_mapper.dart';

class WhatsAppPackStore {
  const WhatsAppPackStore(this._channel);

  final WhatsAppChannel _channel;

  Future<void> install(WhatsAppPack pack) async {
    final root = await _channel.packsRoot();
    final packDir = Directory(
      '${root.path}${Platform.pathSeparator}${pack.id}',
    );
    final operationId = DateTime.now().microsecondsSinceEpoch;
    final tempDir = Directory(
      '${root.path}${Platform.pathSeparator}.${pack.id}.$operationId.tmp',
    );

    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
    await tempDir.create(recursive: true);

    try {
      await _writeBytesAtomic(
        File('${tempDir.path}${Platform.pathSeparator}${pack.trayFileName}'),
        pack.trayBytes,
      );
      for (final sticker in pack.stickers) {
        await _writeBytesAtomic(
          File('${tempDir.path}${Platform.pathSeparator}${sticker.fileName}'),
          sticker.bytes,
        );
      }
      await _writeStringAtomic(
        File(
          '${tempDir.path}${Platform.pathSeparator}${PackFiles.manifestFileName}',
        ),
        '${const JsonEncoder.withIndent(PackFiles.fileIndent).convert(WhatsAppPackManifestMapper.toJson(pack))}${PackFiles.newline}',
      );
      await _replaceDirectory(tempDir, packDir);
    } catch (_) {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
      rethrow;
    }
  }

  Future<void> _replaceDirectory(
    Directory source,
    Directory destination,
  ) async {
    if (await destination.exists()) {
      final backup = Directory(
        '${destination.path}.${DateTime.now().microsecondsSinceEpoch}.bak',
      );
      await destination.rename(backup.path);
      try {
        await source.rename(destination.path);
        await backup.delete(recursive: true);
      } catch (_) {
        if (!await destination.exists() && await backup.exists()) {
          await backup.rename(destination.path);
        }
        rethrow;
      }
    } else {
      await source.rename(destination.path);
    }
  }

  Future<void> _writeBytesAtomic(File destination, List<int> bytes) async {
    final temp = File(PackFiles.tempFilePath(destination.path));
    await temp.writeAsBytes(bytes, flush: true);
    await _replaceFile(temp, destination);
  }

  Future<void> _writeStringAtomic(File destination, String contents) async {
    final temp = File(PackFiles.tempFilePath(destination.path));
    await temp.writeAsString(contents, flush: true);
    await _replaceFile(temp, destination);
  }

  Future<void> _replaceFile(File source, File destination) async {
    if (await destination.exists()) {
      await destination.delete();
    }
    await source.rename(destination.path);
  }
}
