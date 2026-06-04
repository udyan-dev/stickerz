import 'package:freezed_annotation/freezed_annotation.dart';

part 'whatsapp_add_result.freezed.dart';

enum WhatsAppAddStatus {
  completed,
  alreadyAdded,
  cancelled,
  rejected,
  missing,
  providerUnavailable,
}

@freezed
abstract class WhatsAppAddResult with _$WhatsAppAddResult {
  const factory WhatsAppAddResult({
    required WhatsAppAddStatus status,
    String? validationError,
  }) = _WhatsAppAddResult;
}
