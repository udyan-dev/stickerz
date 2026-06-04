import 'dart:convert';
import 'dart:typed_data';

import '../../../core/util/constants/constants.dart';
import 'webp_info.dart';

class WebpParser {
  const WebpParser._();

  static WebpInfo? parse(Uint8List bytes) {
    if (bytes.length < 12 ||
        bytes[0] != 0x52 ||
        bytes[1] != 0x49 ||
        bytes[2] != 0x46 ||
        bytes[3] != 0x46 ||
        bytes[8] != 0x57 ||
        bytes[9] != 0x45 ||
        bytes[10] != 0x42 ||
        bytes[11] != 0x50) {
      return null;
    }

    int? width;
    int? height;
    var animated = false;
    var frameCount = 0;
    var totalDuration = 0;
    int? minDuration;

    var offset = 12;
    while (offset + 8 <= bytes.length) {
      final chunkType = ascii.decode(
        bytes.sublist(offset, offset + 4),
        allowInvalid: true,
      );
      final chunkSize = _read32(bytes, offset + 4);
      final chunkOffset = offset + 8;
      if (chunkSize < 0 || chunkOffset + chunkSize > bytes.length) {
        return null;
      }

      switch (chunkType) {
        case WebpChunkTypes.vp8x:
          if (chunkSize < 10) {
            return null;
          }
          animated = animated || (bytes[chunkOffset] & 0x02) != 0;
          width ??= _read24(bytes, chunkOffset + 4) + 1;
          height ??= _read24(bytes, chunkOffset + 7) + 1;
        case WebpChunkTypes.vp8:
          if (chunkSize >= 10 &&
              bytes[chunkOffset + 3] == 0x9D &&
              bytes[chunkOffset + 4] == 0x01 &&
              bytes[chunkOffset + 5] == 0x2A) {
            width ??= _read16(bytes, chunkOffset + 6) & 0x3FFF;
            height ??= _read16(bytes, chunkOffset + 8) & 0x3FFF;
          }
        case WebpChunkTypes.vp8l:
          if (chunkSize >= 5 && bytes[chunkOffset] == 0x2F) {
            final bits = _read32(bytes, chunkOffset + 1);
            width ??= (bits & 0x3FFF) + 1;
            height ??= ((bits >> 14) & 0x3FFF) + 1;
          }
        case WebpChunkTypes.anim:
          animated = true;
        case WebpChunkTypes.anmf:
          animated = true;
          if (chunkSize >= 16) {
            frameCount += 1;
            final duration = _read24(bytes, chunkOffset + 12);
            totalDuration += duration;
            minDuration = minDuration == null || duration < minDuration
                ? duration
                : minDuration;
          }
      }

      offset = chunkOffset + chunkSize + (chunkSize.isOdd ? 1 : 0);
    }

    if (width == null || height == null || (animated && frameCount == 0)) {
      return null;
    }
    return WebpInfo(
      width: width,
      height: height,
      animated: animated,
      totalDurationMs: totalDuration,
      minFrameDurationMs: minDuration ?? 0,
    );
  }

  static int _read16(Uint8List bytes, int offset) {
    return bytes[offset] | (bytes[offset + 1] << 8);
  }

  static int _read24(Uint8List bytes, int offset) {
    return bytes[offset] | (bytes[offset + 1] << 8) | (bytes[offset + 2] << 16);
  }

  static int _read32(Uint8List bytes, int offset) {
    return bytes[offset] |
        (bytes[offset + 1] << 8) |
        (bytes[offset + 2] << 16) |
        (bytes[offset + 3] << 24);
  }
}
