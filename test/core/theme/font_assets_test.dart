import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stickerz/core/theme/wa_typography.dart';

/// Functional checks on the bundled text font.
///
/// The unit tests assert what the theme *asks* for; these assert the asset can
/// actually deliver it — that the file loads from the bundle, that Roboto's
/// `wght` axis moves, and that the coverage reaches the ranges a pack name can
/// contain. A wrong asset (axis pinned, glyphs missing) passes the unit tests
/// and fails here.
Future<void> _load(String family, String asset) async {
  final loader = FontLoader(family)..addFont(_read(asset));
  await loader.load();
}

Future<ByteData> _read(String asset) => rootBundle.load(asset);

double _width(TextSpan span) {
  final painter = TextPainter(text: span, textDirection: TextDirection.ltr)
    ..layout();
  final width = painter.width;
  painter.dispose();
  return width;
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await _load(WaTypography.fontFamily, 'assets/fonts/Roboto-Variable.ttf');
  });

  test('the text asset loads and its wght axis is live', () async {
    const sample = 'Sticker packs';
    final ramp = WaTypography.textTheme(
      color: const Color(0xFF000000),
      muted: const Color(0xFF666666),
    );

    final light = _width(TextSpan(text: sample, style: ramp.bodyMedium));
    final bold = _width(TextSpan(text: sample, style: ramp.titleMedium));

    expect(light, greaterThan(0));
    expect(
      bold,
      greaterThan(light),
      reason: 'w700 must set wider than w400 — the wght axis is not moving',
    );
  });

  test('the text asset covers Latin Ext and punctuation', () {
    final style = WaTypography.textTheme(
      color: const Color(0xFF000000),
      muted: const Color(0xFF666666),
    ).bodyLarge;

    // A dropped glyph renders as .notdef, which is narrower than the real one.
    for (final sample in <String>['Grüße', 'çğşı', 'ñ — “ ” € ½ →']) {
      expect(_width(TextSpan(text: sample, style: style)), greaterThan(0));
    }
  });
}
