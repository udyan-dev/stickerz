import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'whatsapp_sticker.freezed.dart';

@freezed
abstract class WhatsAppSticker with _$WhatsAppSticker {
  const factory WhatsAppSticker({
    required String fileName,
    required Uint8List bytes,
    @Default(<String>[]) List<String> emojis,
    @Default('') String accessibilityText,
  }) = _WhatsAppSticker;
}
