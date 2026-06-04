import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import '../../../core/error/app_error.dart';
import '../../../core/error/app_result.dart';
import '../../../core/util/constants/constants.dart';
import '../../../core/util/mime.dart';
import '../../whatsapp/util/webp_info.dart';
import '../../whatsapp/util/webp_parser.dart';
import 'pack_models.dart';

class PackValidator {
  static final RegExp _packIdPattern = RegExp(PackPatterns.packId);
  static final RegExp _fileNamePattern = RegExp(PackPatterns.fileName);

  PackManifest normalizeManifest(PackManifest manifest) {
    return manifest.copyWith(
      id: manifest.id.trim().toLowerCase(),
      name: manifest.name.trim(),
      publisher: manifest.publisher.trim(),
      tray: manifest.tray.trim(),
      remoteId: manifest.remoteId?.trim(),
      stickers: manifest.stickers
          .map(_normalizeSticker)
          .toList(growable: false),
    );
  }

  Future<AppResult<StickerPack>> validatePack(
    StickerPack pack, {
    PackValidationMode mode = PackValidationMode.export,
  }) async {
    final result = await validateManifest(
      pack.toManifest(),
      folderPath: pack.folderPath,
      mode: mode,
    );
    return result.mapValue(
      (manifest) => StickerPack.fromManifest(manifest, pack.folderPath),
    );
  }

  Future<AppResult<PackManifest>> validateManifest(
    PackManifest manifest, {
    required String folderPath,
    PackValidationMode mode = PackValidationMode.export,
  }) async {
    final normalized = normalizeManifest(manifest);
    final issues = <String>[];

    if (!_packIdPattern.hasMatch(normalized.id)) {
      issues.add(PackMessages.packIdInvalid);
    }
    if (normalized.name.isEmpty ||
        normalized.name.length > PackRules.packNameMaxLength) {
      issues.add(PackMessages.packNameInvalid);
    }
    if (normalized.publisher.isEmpty ||
        normalized.publisher.length > PackRules.publisherMaxLength) {
      issues.add(PackMessages.publisherInvalid);
    }
    if (normalized.version < 1) {
      issues.add(PackMessages.versionPositive);
    }
    if (normalized.source == PackSource.remote) {
      if (normalized.remoteId == null ||
          !_packIdPattern.hasMatch(normalized.remoteId!)) {
        issues.add(PackMessages.remoteIdInvalid);
      }
    } else if (normalized.remoteId != null) {
      issues.add(PackMessages.customCannotDefineRemoteId);
    }
    if (normalized.animated && normalized.source != PackSource.remote) {
      issues.add(PackMessages.onlyRemoteCanBeAnimated);
    }
    if (normalized.stickers.length > PackRules.maxStickers) {
      issues.add(PackMessages.maxStickerCountExceeded);
    }
    if (mode != PackValidationMode.draft &&
        (normalized.stickers.length < PackRules.minStickers ||
            normalized.stickers.length > PackRules.maxStickers)) {
      issues.add(PackMessages.stickerCountRange);
    }

    final fileNames = <String>{};
    if (normalized.tray.isNotEmpty) {
      if (!_isSafeRelativeName(normalized.tray) ||
          !MimeUtil.isWebpName(normalized.tray)) {
        issues.add(PackMessages.trayFileNameInvalid);
      } else {
        fileNames.add(normalized.tray);
      }
    } else if (mode != PackValidationMode.draft) {
      issues.add(PackMessages.trayRequired);
    }

    for (final sticker in normalized.stickers) {
      if (!_isSafeRelativeName(sticker.file) ||
          !MimeUtil.isWebpName(sticker.file)) {
        issues.add(PackMessages.stickerFileNameInvalid(sticker.file));
      }
      if (!fileNames.add(sticker.file)) {
        issues.add(PackMessages.stickerNamesUnique);
      }
      final maxAccessibility = normalized.animated
          ? PackRules.animatedAccessibilityMaxLength
          : PackRules.staticAccessibilityMaxLength;
      if (sticker.accessibilityText.length > maxAccessibility) {
        issues.add(PackMessages.accessibilityTooLong(sticker.file));
      }
    }

    if (issues.isNotEmpty) {
      return AppResult.failure(_packError(mode, issues));
    }

    if (normalized.tray.isNotEmpty) {
      final trayPath = _resolvePath(folderPath, normalized.tray);
      if (trayPath == null || !await File(trayPath).exists()) {
        issues.add(PackMessages.trayMissing);
      } else {
        final trayValidation = await validateTrayFile(trayPath);
        if (trayValidation.isFailure) {
          issues.add(trayValidation.errorOrNull!.safeMessage);
        }
      }
    }

    var hasAnimatedSticker = false;
    var hasStaticSticker = false;
    for (final sticker in normalized.stickers) {
      final stickerPath = _resolvePath(folderPath, sticker.file);
      if (stickerPath == null || !await File(stickerPath).exists()) {
        issues.add(PackMessages.stickerMissing(sticker.file));
        continue;
      }
      final stickerValidation = await validateStickerFile(
        stickerPath,
        animatedPack: normalized.animated,
      );
      if (stickerValidation.isFailure) {
        issues.add(
          PackMessages.stickerValidation(
            sticker.file,
            stickerValidation.errorOrNull!.safeMessage,
          ),
        );
        continue;
      }
      final info = stickerValidation.valueOrNull!;
      if (info.animated) {
        hasAnimatedSticker = true;
      } else {
        hasStaticSticker = true;
      }
    }

    if (normalized.animated && hasStaticSticker) {
      issues.add(PackMessages.animatedPackContainsStatic);
    }
    if (!normalized.animated && hasAnimatedSticker) {
      issues.add(PackMessages.staticPackContainsAnimated);
    }

    if (issues.isNotEmpty) {
      return AppResult.failure(_packError(mode, issues));
    }

    return AppResult.success(normalized);
  }

  Future<AppResult<WebpInfo>> validateStickerFile(
    String path, {
    required bool animatedPack,
  }) async {
    final bytes = await File(path).readAsBytes();
    return validateStickerBytes(bytes, animatedPack: animatedPack);
  }

  Future<AppResult<WebpInfo>> validateTrayFile(String path) async {
    final bytes = await File(path).readAsBytes();
    return validateTrayBytes(bytes);
  }

  AppResult<WebpInfo> validateStickerBytes(
    Uint8List bytes, {
    required bool animatedPack,
  }) {
    if (MimeUtil.detect(bytes) != ImageMimeType.webp) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.stickerMustBeWebp),
      );
    }
    final info = WebpParser.parse(bytes);
    if (info == null) {
      return AppResult.failure(
        const AppError.parse(message: PackMessages.malformedStickerWebp),
      );
    }
    if (info.width != PackRules.stickerSize ||
        info.height != PackRules.stickerSize) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.stickerDimensions),
      );
    }
    if (animatedPack) {
      if (!info.animated) {
        return AppResult.failure(
          const AppError.validation(
            message: PackMessages.animatedPackRequiresAnimatedWebp,
          ),
        );
      }
      if (bytes.length > PackRules.animatedStickerMaxBytes) {
        return AppResult.failure(
          const AppError.validation(
            message: PackMessages.animatedStickerTooLarge,
          ),
        );
      }
      if (info.minFrameDurationMs < PackRules.minAnimatedFrameDurationMs ||
          info.totalDurationMs > PackRules.maxAnimatedDurationMs) {
        return AppResult.failure(
          const AppError.validation(
            message: PackMessages.animatedStickerTimingInvalid,
          ),
        );
      }
    } else {
      if (info.animated) {
        return AppResult.failure(
          const AppError.validation(
            message: PackMessages.staticPackCannotContainAnimatedWebp,
          ),
        );
      }
      if (bytes.length > PackRules.staticStickerMaxBytes) {
        return AppResult.failure(
          const AppError.validation(message: PackMessages.stickerTooLarge),
        );
      }
    }
    return AppResult.success(info);
  }

  AppResult<WebpInfo> validateTrayBytes(Uint8List bytes) {
    if (MimeUtil.detect(bytes) != ImageMimeType.webp) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.trayMustBeWebp),
      );
    }
    final info = WebpParser.parse(bytes);
    if (info == null) {
      return AppResult.failure(
        const AppError.parse(message: PackMessages.malformedTrayWebp),
      );
    }
    if (info.animated) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.trayMustBeStatic),
      );
    }
    if (info.width != PackRules.traySize || info.height != PackRules.traySize) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.trayDimensions),
      );
    }
    if (bytes.length > PackRules.trayMaxBytes) {
      return AppResult.failure(
        const AppError.validation(message: PackMessages.trayTooLarge),
      );
    }
    return AppResult.success(info);
  }

  StickerItem _normalizeSticker(StickerItem item) {
    final emojis = item.emojis
        .map((emoji) => emoji.trim())
        .where((emoji) => emoji.isNotEmpty)
        .toSet()
        .take(3)
        .toList(growable: false);
    return item.copyWith(
      file: item.file.trim(),
      emojis: emojis,
      accessibilityText: item.accessibilityText.trim(),
    );
  }

  bool _isSafeRelativeName(String value) {
    if (value.isEmpty || value.startsWith('.') || value.contains('..')) {
      return false;
    }
    if (value.contains('/') || value.contains(r'\')) {
      return false;
    }
    if (p.basename(value) != value) {
      return false;
    }
    return _fileNamePattern.hasMatch(value);
  }

  String? _resolvePath(String folderPath, String relativeName) {
    if (!_isSafeRelativeName(relativeName)) {
      return null;
    }
    final root = p.normalize(folderPath);
    final resolved = p.normalize(p.join(root, relativeName));
    if (!p.isWithin(root, resolved) && root != resolved) {
      return null;
    }
    return resolved;
  }

  AppError _packError(PackValidationMode mode, List<String> reasons) {
    if (mode == PackValidationMode.draft) {
      return AppError.validation(message: reasons.first, reasons: reasons);
    }
    return AppError.invalidPack(message: reasons.first, reasons: reasons);
  }
}
