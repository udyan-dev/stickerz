import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../../core/util/constants/constants.dart';

part 'pack_models.freezed.dart';

enum PackSource { custom, remote }

enum PackValidationMode { draft, install, export }

class PackRules {
  static const int minStickers = 3;
  static const int maxStickers = 30;
  static const int stickerSize = 512;
  static const int traySize = 96;
  static const int staticStickerMaxBytes = 100 * 1024;
  static const int animatedStickerMaxBytes = 500 * 1024;
  static const int trayMaxBytes = 50 * 1024;
  static const int packNameMaxLength = 128;
  static const int publisherMaxLength = 128;
  static const int staticAccessibilityMaxLength = 125;
  static const int animatedAccessibilityMaxLength = 255;
  static const int manifestMaxBytes = 64 * 1024;
  static const int maxZipEntries = 32;
  static const int maxZipAssetBytes = 600 * 1024;
  static const int maxAnimatedDurationMs = 10000;
  static const int minAnimatedFrameDurationMs = 8;
}

@freezed
abstract class StickerItem with _$StickerItem {
  const StickerItem._();

  const factory StickerItem({
    required String file,
    @Default(<String>[]) List<String> emojis,
    @Default('') String accessibilityText,
  }) = _StickerItem;

  static StickerItem fromJson(Map<String, dynamic> json) {
    return StickerItem(
      file: json[PackJsonKeys.file]?.toString() ?? '',
      emojis:
          (json[PackJsonKeys.emojis] as List?)
              ?.map((value) => value.toString())
              .toList(growable: false) ??
          const <String>[],
      accessibilityText: json[PackJsonKeys.accessibilityText]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      PackJsonKeys.file: file,
      PackJsonKeys.emojis: emojis,
      PackJsonKeys.accessibilityText: accessibilityText,
    };
  }
}

@freezed
abstract class PackManifest with _$PackManifest {
  const PackManifest._();

  const factory PackManifest({
    required String id,
    required String name,
    required String publisher,
    @Default(false) bool animated,
    required String tray,
    required PackSource source,
    String? remoteId,
    @Default(1) int version,
    @Default(<StickerItem>[]) List<StickerItem> stickers,
  }) = _PackManifest;

  static PackManifest fromJson(Map<String, dynamic> json) {
    return PackManifest(
      id: json[PackJsonKeys.id]?.toString() ?? '',
      name: json[PackJsonKeys.name]?.toString() ?? '',
      publisher: json[PackJsonKeys.publisher]?.toString() ?? '',
      animated: json[PackJsonKeys.animated] as bool? ?? false,
      tray: json[PackJsonKeys.tray]?.toString() ?? '',
      source: _packSourceFromJson(json[PackJsonKeys.source]),
      remoteId: json[PackJsonKeys.remoteId]?.toString(),
      version: (json[PackJsonKeys.version] as num?)?.toInt() ?? 1,
      stickers:
          (json[PackJsonKeys.stickers] as List?)
              ?.whereType<Map>()
              .map(
                (value) =>
                    StickerItem.fromJson(Map<String, dynamic>.from(value)),
              )
              .toList(growable: false) ??
          const <StickerItem>[],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      PackJsonKeys.id: id,
      PackJsonKeys.name: name,
      PackJsonKeys.publisher: publisher,
      PackJsonKeys.animated: animated,
      PackJsonKeys.tray: tray,
      PackJsonKeys.source: source.name,
      PackJsonKeys.remoteId: remoteId,
      PackJsonKeys.version: version,
      PackJsonKeys.stickers: stickers
          .map((item) => item.toJson())
          .toList(growable: false),
    };
  }
}

@freezed
abstract class StickerPack with _$StickerPack {
  const StickerPack._();

  const factory StickerPack({
    required String id,
    required String name,
    required String publisher,
    @Default(false) bool animated,
    required String tray,
    required PackSource source,
    String? remoteId,
    @Default(1) int version,
    @Default(<StickerItem>[]) List<StickerItem> stickers,
    required String folderPath,
  }) = _StickerPack;

  String get trayPath => p.join(folderPath, tray);

  String stickerPath(String fileName) => p.join(folderPath, fileName);

  PackManifest toManifest() {
    return PackManifest(
      id: id,
      name: name,
      publisher: publisher,
      animated: animated,
      tray: tray,
      source: source,
      remoteId: remoteId,
      version: version,
      stickers: stickers,
    );
  }

  factory StickerPack.fromManifest(PackManifest manifest, String folderPath) {
    return StickerPack(
      id: manifest.id,
      name: manifest.name,
      publisher: manifest.publisher,
      animated: manifest.animated,
      tray: manifest.tray,
      source: manifest.source,
      remoteId: manifest.remoteId,
      version: manifest.version,
      stickers: manifest.stickers,
      folderPath: folderPath,
    );
  }
}

PackSource _packSourceFromJson(Object? raw) {
  return switch (raw?.toString()) {
    PackFiles.remoteSource => PackSource.remote,
    _ => PackSource.custom,
  };
}
