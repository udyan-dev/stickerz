import 'dart:typed_data';

import '../../editor/data/webp_encoder.dart';
import '../../whatsapp/data/whatsapp_channel.dart';

class NativeWebpEncoder implements WebpEncoder {
  const NativeWebpEncoder(this._channel);

  final WhatsAppChannel _channel;

  @override
  Future<Uint8List> encodeWebp({
    required Uint8List bytes,
    required int quality,
    required bool lossless,
  }) {
    return _channel.encodeWebp(
      bytes: bytes,
      quality: quality,
      lossless: lossless,
    );
  }
}
