import 'package:flutter/foundation.dart';

import '../../../core/util/constants/constants.dart';
import '../domain/models/whatsapp_pack/whatsapp_pack.dart';
import '../domain/models/whatsapp_sticker/whatsapp_sticker.dart';
import '../domain/whatsapp_pack_rules.dart';
import '../domain/whatsapp_sticker_exception.dart';
import 'webp_parser.dart';
import 'whatsapp_file_names.dart';

class WhatsAppPackValidator {
  const WhatsAppPackValidator();

  Future<WhatsAppPack> validate(WhatsAppPack pack) {
    return compute(
      _validatePackInBackground,
      pack,
      debugLabel: WhatsAppMessages.validatePackDebugLabel,
    );
  }

  WhatsAppPack validateSync(WhatsAppPack pack) {
    final id = normalizePackId(pack.id);
    final name = pack.name.trim();
    final publisher = pack.publisher.trim();
    final trayFileName = pack.trayFileName.trim();
    final seenFiles = <String>{};

    if (name.isEmpty || name.length > WhatsAppPackRules.packNameMaxLength) {
      throw const WhatsAppStickerException(WhatsAppMessages.packNameLength);
    }
    if (publisher.isEmpty ||
        publisher.length > WhatsAppPackRules.publisherMaxLength) {
      throw const WhatsAppStickerException(WhatsAppMessages.publisherLength);
    }
    if (pack.version < 1) {
      throw const WhatsAppStickerException(WhatsAppMessages.versionPositive);
    }
    if (!WhatsAppFileNames.isSafeWebpFileName(trayFileName) ||
        !seenFiles.add(trayFileName)) {
      throw const WhatsAppStickerException(WhatsAppMessages.safeTrayFileName);
    }
    _validateWebp(
      pack.trayBytes,
      width: WhatsAppPackRules.traySize,
      height: WhatsAppPackRules.traySize,
      maxBytes: WhatsAppPackRules.trayMaxBytes,
      animated: false,
      label: WhatsAppMessages.trayIconLabel,
    );

    if (pack.stickers.length < WhatsAppPackRules.minStickers ||
        pack.stickers.length > WhatsAppPackRules.maxStickers) {
      throw const WhatsAppStickerException(WhatsAppMessages.stickerCountRange);
    }

    final stickers = <WhatsAppSticker>[];
    for (final sticker in pack.stickers) {
      final fileName = sticker.fileName.trim();
      if (!WhatsAppFileNames.isSafeWebpFileName(fileName) ||
          !seenFiles.add(fileName)) {
        throw WhatsAppStickerException(
          WhatsAppMessages.invalidStickerFileName(fileName),
        );
      }
      _validateWebp(
        sticker.bytes,
        width: WhatsAppPackRules.stickerSize,
        height: WhatsAppPackRules.stickerSize,
        maxBytes: pack.animated
            ? WhatsAppPackRules.animatedStickerMaxBytes
            : WhatsAppPackRules.staticStickerMaxBytes,
        animated: pack.animated,
        label: fileName,
      );
      stickers.add(
        sticker.copyWith(
          fileName: fileName,
          emojis: _sanitizeEmojis(sticker.emojis),
          accessibilityText: _sanitizeAccessibilityText(
            sticker.accessibilityText,
            animated: pack.animated,
          ),
        ),
      );
    }

    return pack.copyWith(
      id: id,
      name: name,
      publisher: publisher,
      trayFileName: trayFileName,
      stickers: stickers,
    );
  }

  String normalizePackId(String value) {
    final id = WhatsAppFileNames.normalizePackId(value);
    if (!WhatsAppFileNames.isPackId(id)) {
      throw const WhatsAppStickerException(WhatsAppMessages.packIdRules);
    }
    return id;
  }

  List<String> _sanitizeEmojis(List<String> emojis) {
    final normalized = <String>[];
    for (final emoji in emojis) {
      final value = emoji.trim();
      if (value.isNotEmpty && !normalized.contains(value)) {
        normalized.add(value);
      }
      if (normalized.length == 3) {
        break;
      }
    }
    return normalized;
  }

  String _sanitizeAccessibilityText(String text, {required bool animated}) {
    final value = text.trim();
    final maxLength = animated
        ? WhatsAppPackRules.animatedAccessibilityMaxLength
        : WhatsAppPackRules.staticAccessibilityMaxLength;
    if (value.length > maxLength) {
      throw WhatsAppStickerException(
        WhatsAppMessages.accessibilityMaxLength(maxLength),
      );
    }
    return value;
  }

  void _validateWebp(
    Uint8List bytes, {
    required int width,
    required int height,
    required int maxBytes,
    required bool animated,
    required String label,
  }) {
    if (bytes.length > maxBytes) {
      throw WhatsAppStickerException(WhatsAppMessages.exceedsSizeLimit(label));
    }
    final info = WebpParser.parse(bytes);
    if (info == null) {
      throw WhatsAppStickerException(WhatsAppMessages.mustBeValidWebp(label));
    }
    if (info.width != width || info.height != height) {
      throw WhatsAppStickerException(
        WhatsAppMessages.mustBeDimensions(label, width, height),
      );
    }
    if (animated != info.animated) {
      throw WhatsAppStickerException(
        animated
            ? WhatsAppMessages.mustBeAnimatedWebp(label)
            : WhatsAppMessages.mustBeStaticWebp(label),
      );
    }
    if (animated &&
        (info.minFrameDurationMs <
                WhatsAppPackRules.minAnimatedFrameDurationMs ||
            info.totalDurationMs > WhatsAppPackRules.maxAnimatedDurationMs)) {
      throw WhatsAppStickerException(
        WhatsAppMessages.invalidAnimationTiming(label),
      );
    }
  }
}

WhatsAppPack _validatePackInBackground(WhatsAppPack pack) {
  return const WhatsAppPackValidator().validateSync(pack);
}
