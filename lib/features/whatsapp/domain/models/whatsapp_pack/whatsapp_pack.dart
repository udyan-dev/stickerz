import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../whatsapp_sticker/whatsapp_sticker.dart';

part 'whatsapp_pack.freezed.dart';

@freezed
abstract class WhatsAppPack with _$WhatsAppPack {
  const factory WhatsAppPack({
    required String id,
    required String name,
    required String publisher,
    required String trayFileName,
    required Uint8List trayBytes,
    required List<WhatsAppSticker> stickers,
    @Default(false) bool animated,
    @Default(1) int version,
  }) = _WhatsAppPack;
}
