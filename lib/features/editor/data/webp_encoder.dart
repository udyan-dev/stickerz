import 'dart:typed_data';

abstract interface class WebpEncoder {
  Future<Uint8List> encodeWebp({
    required Uint8List bytes,
    required int quality,
    required bool lossless,
  });
}
