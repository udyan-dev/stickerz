import '../../../core/error/app_error.dart';

class WhatsAppStickerException implements Exception {
  const WhatsAppStickerException(
    this.message, {
    this.type = AppErrorType.invalidPack,
    this.debugDetails,
  });

  final String message;
  final AppErrorType type;
  final String? debugDetails;

  AppError toAppError() {
    return switch (type) {
      AppErrorType.validation => AppError.validation(
        message: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.invalidPack => AppError.invalidPack(
        message: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.parse => AppError.parse(
        message: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.storage => AppError.storage(
        message: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.platform => AppError.platform(
        message: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.whatsappMissing => AppError.whatsappMissing(
        debugDetails: debugDetails,
      ),
      AppErrorType.businessMissing => AppError.businessMissing(
        debugDetails: debugDetails,
      ),
      AppErrorType.noCompatibleTarget => AppError.noCompatibleTarget(
        debugDetails: debugDetails,
      ),
      AppErrorType.providerUnavailable => AppError.providerUnavailable(
        debugDetails: debugDetails,
      ),
      AppErrorType.cancelled => AppError.cancelled(debugDetails: debugDetails),
      AppErrorType.exportCancelled => AppError.exportCancelled(
        debugDetails: debugDetails,
      ),
      AppErrorType.exportRejected => AppError.exportRejected(
        reason: message,
        debugDetails: debugDetails,
      ),
      AppErrorType.unknown => AppError.unknown(
        message: message,
        debugDetails: debugDetails,
      ),
    };
  }

  @override
  String toString() => message;
}
