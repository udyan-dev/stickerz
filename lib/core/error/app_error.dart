import '../util/constants/constants.dart';

enum AppErrorType {
  cancelled,
  validation,
  invalidPack,
  parse,
  storage,
  platform,
  whatsappMissing,
  businessMissing,
  noCompatibleTarget,
  providerUnavailable,
  exportCancelled,
  exportRejected,
  unknown,
}

class AppError {
  const AppError({
    required this.type,
    required this.message,
    this.reasons = const <String>[],
    this.path,
    this.reason,
    this.code,
    this.debugDetails,
  });

  const AppError.cancelled({String? code, String? debugDetails})
    : this(
        type: AppErrorType.cancelled,
        message: AppErrorStrings.operationCancelled,
        code: code,
        debugDetails: debugDetails,
      );

  const AppError.validation({
    required String message,
    List<String> reasons = const <String>[],
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.validation,
         message: message,
         reasons: reasons,
         code: code,
         debugDetails: debugDetails,
       );

  const AppError.invalidPack({
    required String message,
    List<String> reasons = const <String>[],
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.invalidPack,
         message: message,
         reasons: reasons,
         code: code,
         debugDetails: debugDetails,
       );

  const AppError.parse({
    required String message,
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.parse,
         message: message,
         code: code,
         debugDetails: debugDetails,
       );

  const AppError.storage({
    required String message,
    String? path,
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.storage,
         message: message,
         path: path,
         code: code,
         debugDetails: debugDetails,
       );

  const AppError.platform({
    required String message,
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.platform,
         message: message,
         code: code,
         debugDetails: debugDetails,
       );

  const AppError.whatsappMissing({String? debugDetails})
    : this(
        type: AppErrorType.whatsappMissing,
        message: AppErrorStrings.whatsappMissing,
        debugDetails: debugDetails,
      );

  const AppError.businessMissing({String? debugDetails})
    : this(
        type: AppErrorType.businessMissing,
        message: AppErrorStrings.whatsappBusinessMissing,
        debugDetails: debugDetails,
      );

  const AppError.noCompatibleTarget({String? debugDetails})
    : this(
        type: AppErrorType.noCompatibleTarget,
        message: AppErrorStrings.noCompatibleTarget,
        debugDetails: debugDetails,
      );

  const AppError.providerUnavailable({String? debugDetails})
    : this(
        type: AppErrorType.providerUnavailable,
        message: AppErrorStrings.providerUnavailable,
        debugDetails: debugDetails,
      );

  const AppError.exportCancelled({String? debugDetails})
    : this(
        type: AppErrorType.exportCancelled,
        message: AppErrorStrings.exportCancelled,
        debugDetails: debugDetails,
      );

  const AppError.exportRejected({String? reason, String? debugDetails})
    : this(
        type: AppErrorType.exportRejected,
        message: AppErrorStrings.exportRejected,
        reason: reason,
        debugDetails: debugDetails,
      );

  const AppError.unknown({
    required String message,
    String? code,
    String? debugDetails,
  }) : this(
         type: AppErrorType.unknown,
         message: message,
         code: code,
         debugDetails: debugDetails,
       );

  final AppErrorType type;
  final String message;
  final List<String> reasons;
  final String? path;
  final String? reason;
  final String? code;
  final String? debugDetails;

  String get safeMessage => message;

  String? get safeDebugDetails => debugDetails;

  String get userMessage => switch (type) {
    AppErrorType.cancelled => AppErrorStrings.operationCancelled,
    AppErrorType.validation => message,
    AppErrorType.invalidPack => message,
    AppErrorType.parse => message,
    AppErrorType.storage => message,
    AppErrorType.platform => message,
    AppErrorType.whatsappMissing => AppErrorStrings.whatsappMissing,
    AppErrorType.businessMissing => AppErrorStrings.whatsappBusinessMissing,
    AppErrorType.noCompatibleTarget => AppErrorStrings.noCompatibleTarget,
    AppErrorType.providerUnavailable => AppErrorStrings.providerUnavailable,
    AppErrorType.exportCancelled => AppErrorStrings.exportCancelled,
    AppErrorType.exportRejected => reason ?? AppErrorStrings.exportRejected,
    AppErrorType.unknown => message,
  };

  T maybeWhen<T>({
    T Function(String message, List<String> reasons, String? debugDetails)?
    validation,
    T Function(String message, List<String> reasons, String? debugDetails)?
    invalidPack,
    T Function(String message, String? debugDetails)? parse,
    T Function(String message, String? path, String? debugDetails)? storage,
    T Function(String message, String? code, String? debugDetails)? platform,
    T Function(String? debugDetails)? cancelled,
    T Function(String? debugDetails)? exportCancelled,
    T Function(String? reason, String? debugDetails)? exportRejected,
    T Function(String? debugDetails)? whatsappMissing,
    T Function(String? debugDetails)? businessMissing,
    T Function(String? debugDetails)? noCompatibleTarget,
    T Function(String? debugDetails)? providerUnavailable,
    T Function(String message, String? debugDetails)? unknown,
    required T Function() orElse,
  }) {
    return switch (type) {
      AppErrorType.validation =>
        validation?.call(message, reasons, debugDetails) ?? orElse(),
      AppErrorType.invalidPack =>
        invalidPack?.call(message, reasons, debugDetails) ?? orElse(),
      AppErrorType.parse => parse?.call(message, debugDetails) ?? orElse(),
      AppErrorType.storage =>
        storage?.call(message, path, debugDetails) ?? orElse(),
      AppErrorType.platform =>
        platform?.call(message, code, debugDetails) ?? orElse(),
      AppErrorType.cancelled => cancelled?.call(debugDetails) ?? orElse(),
      AppErrorType.exportCancelled =>
        exportCancelled?.call(debugDetails) ?? orElse(),
      AppErrorType.exportRejected =>
        exportRejected?.call(reason, debugDetails) ?? orElse(),
      AppErrorType.whatsappMissing =>
        whatsappMissing?.call(debugDetails) ?? orElse(),
      AppErrorType.businessMissing =>
        businessMissing?.call(debugDetails) ?? orElse(),
      AppErrorType.noCompatibleTarget =>
        noCompatibleTarget?.call(debugDetails) ?? orElse(),
      AppErrorType.providerUnavailable =>
        providerUnavailable?.call(debugDetails) ?? orElse(),
      AppErrorType.unknown => unknown?.call(message, debugDetails) ?? orElse(),
    };
  }

  @override
  String toString() {
    return 'AppError(type: $type, message: $message)';
  }
}
