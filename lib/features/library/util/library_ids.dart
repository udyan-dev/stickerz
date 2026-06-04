import 'dart:math';

import '../../../core/util/constants/constants.dart';

class LibraryIds {
  const LibraryIds._();

  static final Random _random = Random.secure();
  static final RegExp _invalid = RegExp(
    PackPatterns.invalidLibraryIdCharacters,
  );

  static String sanitize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(_invalid, '_')
        .replaceAll(RegExp(PackPatterns.repeatedUnderscores), '_')
        .replaceAll(RegExp(PackPatterns.edgeSeparators), '');
  }

  static String newPackId(String name) {
    final base = sanitize(name);
    final prefix = base.isEmpty ? PackFiles.defaultPackPrefix : base;
    return '${prefix}_${newOperationId()}';
  }

  static String newOperationId() {
    final micros = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final entropy = _random.nextInt(1 << 32).toRadixString(36);
    return '$micros$entropy';
  }
}
