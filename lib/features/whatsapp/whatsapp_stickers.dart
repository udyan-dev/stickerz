import 'dart:typed_data';

import 'data/whatsapp_channel.dart';
import 'data/whatsapp_pack_store.dart';
import 'domain/models/whatsapp_add_result/whatsapp_add_result.dart';
import 'domain/models/whatsapp_pack/whatsapp_pack.dart';
import 'domain/models/whatsapp_pack_status/whatsapp_pack_status.dart';
import 'domain/whatsapp_target.dart';
import 'util/whatsapp_pack_validator.dart';

class WhatsAppStickers {
  factory WhatsAppStickers({
    WhatsAppChannel? channel,
    WhatsAppPackValidator validator = const WhatsAppPackValidator(),
  }) {
    return WhatsAppStickers._(
      channel: channel ?? WhatsAppChannel(),
      validator: validator,
    );
  }

  WhatsAppStickers._({
    required WhatsAppChannel channel,
    required this.validator,
  }) : _channel = channel,
       _store = WhatsAppPackStore(channel);

  factory WhatsAppStickers.withChannel({
    required WhatsAppChannel channel,
    WhatsAppPackValidator validator = const WhatsAppPackValidator(),
  }) {
    return WhatsAppStickers._(channel: channel, validator: validator);
  }

  final WhatsAppChannel _channel;
  final WhatsAppPackValidator validator;
  final WhatsAppPackStore _store;

  Future<void> installPack(WhatsAppPack pack) async {
    await _store.install(await validator.validate(pack));
  }

  Future<List<WhatsAppTarget>> installedTargets() {
    return _channel.installedTargets();
  }

  Future<WhatsAppPackStatus> packStatus(String packId) {
    return _channel.packStatus(validator.normalizePackId(packId));
  }

  Future<WhatsAppAddResult> addPack({
    required String packId,
    required String packName,
  }) {
    return _channel.addPack(
      packId: validator.normalizePackId(packId),
      packName: packName,
    );
  }

  Future<WhatsAppAddResult> installAndAdd(WhatsAppPack pack) async {
    final normalized = await validator.validate(pack);
    await _store.install(normalized);
    return _channel.addPack(packId: normalized.id, packName: normalized.name);
  }

  Future<Uint8List> encodeWebp({
    required Uint8List bytes,
    int quality = 90,
    bool lossless = false,
  }) {
    return _channel.encodeWebp(
      bytes: bytes,
      quality: quality,
      lossless: lossless,
    );
  }
}
