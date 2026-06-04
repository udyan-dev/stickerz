import '../../../core/util/constants/constants.dart';
import '../domain/models/whatsapp_pack/whatsapp_pack.dart';

class WhatsAppPackManifestMapper {
  const WhatsAppPackManifestMapper._();

  static Map<String, dynamic> toJson(WhatsAppPack pack) {
    return <String, dynamic>{
      PackJsonKeys.id: pack.id,
      PackJsonKeys.name: pack.name,
      PackJsonKeys.publisher: pack.publisher,
      PackJsonKeys.animated: pack.animated,
      PackJsonKeys.tray: pack.trayFileName,
      PackJsonKeys.source: PackFiles.customSource,
      PackJsonKeys.version: pack.version,
      PackJsonKeys.stickers: pack.stickers
          .map(
            (sticker) => <String, dynamic>{
              PackJsonKeys.file: sticker.fileName,
              PackJsonKeys.emojis: sticker.emojis,
              PackJsonKeys.accessibilityText: sticker.accessibilityText,
            },
          )
          .toList(growable: false),
    };
  }
}
