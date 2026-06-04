import '../../../core/util/constants/constants.dart';

class WhatsAppFileNames {
  WhatsAppFileNames._();

  static final RegExp packIdPattern = RegExp(PackPatterns.packId);
  static final RegExp fileNamePattern = RegExp(PackPatterns.fileName);

  static String normalizePackId(String value) {
    return value.trim().toLowerCase();
  }

  static bool isPackId(String value) {
    return packIdPattern.hasMatch(value);
  }

  static bool isSafeWebpFileName(String value) {
    return value.isNotEmpty &&
        !value.startsWith('.') &&
        !value.contains('..') &&
        !value.contains('/') &&
        !value.contains(r'\') &&
        value.toLowerCase().endsWith(PackFiles.webpExtension) &&
        fileNamePattern.hasMatch(value);
  }
}
