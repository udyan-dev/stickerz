import 'dart:io';

import 'package:flutter/services.dart';

import '../../../core/util/constants/constants.dart';
import '../../../core/error/app_error.dart';
import '../domain/models/whatsapp_add_result/whatsapp_add_result.dart';
import '../domain/models/whatsapp_pack_status/whatsapp_pack_status.dart';
import '../domain/whatsapp_target.dart';
import '../domain/whatsapp_sticker_exception.dart';

class WhatsAppChannel {
  WhatsAppChannel({MethodChannel? channel})
    : _channel =
          channel ?? const MethodChannel(WhatsAppChannelKeys.channelName);

  final MethodChannel _channel;

  Future<Directory> packsRoot() async {
    final path = await _channel.invokeMethod<String>(
      WhatsAppChannelKeys.getPacksDirectory,
    );
    if (path == null || path.isEmpty) {
      throw const WhatsAppStickerException(
        WhatsAppMessages.packsDirectoryUnavailable,
        type: AppErrorType.storage,
      );
    }
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<List<WhatsAppTarget>> installedTargets() async {
    final result = await _invokeMap(WhatsAppChannelKeys.getTargets);
    return _readTargets(result[WhatsAppChannelKeys.installed]);
  }

  Future<WhatsAppPackStatus> packStatus(String packId) async {
    final result = await _invokeMap(
      WhatsAppChannelKeys.canAddPack,
      <String, dynamic>{WhatsAppChannelKeys.packId: packId},
    );
    return WhatsAppPackStatus(
      installed: _readTargets(result[WhatsAppChannelKeys.installed]),
      whitelisted: _readTargets(result[WhatsAppChannelKeys.whitelisted]),
    );
  }

  Future<WhatsAppAddResult> addPack({
    required String packId,
    required String packName,
  }) async {
    final result =
        await _invokeMap(WhatsAppChannelKeys.addPack, <String, dynamic>{
          WhatsAppChannelKeys.packId: packId,
          WhatsAppChannelKeys.packName: packName.trim(),
        });
    return WhatsAppAddResult(
      status: _readAddStatus(result[WhatsAppChannelKeys.status]),
      validationError: result[WhatsAppChannelKeys.validationError]?.toString(),
    );
  }

  Future<Uint8List> encodeWebp({
    required Uint8List bytes,
    int quality = 90,
    bool lossless = false,
  }) async {
    final encoded = await _channel.invokeMethod<Uint8List>(
      WhatsAppChannelKeys.encodeWebp,
      <String, dynamic>{
        WhatsAppChannelKeys.bytes: bytes,
        WhatsAppChannelKeys.quality: quality.clamp(0, 100),
        WhatsAppChannelKeys.lossless: lossless,
      },
    );
    if (encoded == null || encoded.isEmpty) {
      throw const WhatsAppStickerException(
        WhatsAppMessages.webpEncodingFailed,
        type: AppErrorType.platform,
      );
    }
    return encoded;
  }

  Future<String?> takeIncomingPack() {
    return _channel.invokeMethod<String>(WhatsAppChannelKeys.takeIncomingPack);
  }

  Future<String?> copyImportUri(String uri) {
    return _channel.invokeMethod<String>(
      WhatsAppChannelKeys.copyImportUri,
      <String, dynamic>{WhatsAppChannelKeys.uri: uri},
    );
  }

  Future<Map<String, dynamic>> _invokeMap(
    String method, [
    Map<String, dynamic>? arguments,
  ]) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      method,
      arguments,
    );
    return Map<String, dynamic>.from(result ?? const <String, dynamic>{});
  }

  WhatsAppAddStatus _readAddStatus(Object? value) {
    return switch (value?.toString()) {
      WhatsAppChannelKeys.completed => WhatsAppAddStatus.completed,
      WhatsAppChannelKeys.alreadyAdded => WhatsAppAddStatus.alreadyAdded,
      WhatsAppChannelKeys.cancelled => WhatsAppAddStatus.cancelled,
      WhatsAppChannelKeys.rejected => WhatsAppAddStatus.rejected,
      WhatsAppChannelKeys.missing => WhatsAppAddStatus.missing,
      _ => WhatsAppAddStatus.providerUnavailable,
    };
  }

  List<WhatsAppTarget> _readTargets(Object? raw) {
    final items = raw is List ? raw : const <Object?>[];
    return items
        .map(
          (item) => switch (item?.toString()) {
            WhatsAppChannelKeys.consumer => WhatsAppTarget.consumer,
            WhatsAppChannelKeys.business => WhatsAppTarget.business,
            _ => null,
          },
        )
        .whereType<WhatsAppTarget>()
        .toList(growable: false);
  }
}
