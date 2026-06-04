import 'package:freezed_annotation/freezed_annotation.dart';

import '../../whatsapp_target.dart';

part 'whatsapp_pack_status.freezed.dart';

@freezed
abstract class WhatsAppPackStatus with _$WhatsAppPackStatus {
  const factory WhatsAppPackStatus({
    @Default(<WhatsAppTarget>[]) List<WhatsAppTarget> installed,
    @Default(<WhatsAppTarget>[]) List<WhatsAppTarget> whitelisted,
  }) = _WhatsAppPackStatus;
}
