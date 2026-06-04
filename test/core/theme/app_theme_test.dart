import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stickerz/core/theme/app_theme.dart';
import 'package:stickerz/core/theme/wa_colors.dart';
import 'package:stickerz/core/theme/wa_palette.dart';

/// WCAG 2.1 relative-contrast ratio.
double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final lighter = la > lb ? la : lb;
  final darker = la > lb ? lb : la;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('WhatsApp colour scheme', () {
    test('light scheme carries the WhatsApp values', () {
      final scheme = AppTheme.light.colorScheme;

      expect(scheme.brightness, Brightness.light);
      expect(scheme.primary, WaColors.lightPrimary);
      expect(scheme.surface, WaColors.lightSurface);
      expect(scheme.surfaceContainer, WaColors.lightSurfaceContainer);
      expect(scheme.onSurface, WaColors.lightOnSurface);
      expect(scheme.onSurfaceVariant, WaColors.lightOnSurfaceVariant);
      expect(scheme.primaryContainer, WaColors.lightBubbleOut);
    });

    test('dark scheme carries the WhatsApp values', () {
      final scheme = AppTheme.dark.colorScheme;

      expect(scheme.brightness, Brightness.dark);
      expect(scheme.primary, WaColors.darkPrimary);
      expect(scheme.surface, WaColors.darkSurface);
      expect(scheme.surfaceContainer, WaColors.darkSurfaceContainer);
      expect(scheme.onSurface, WaColors.darkOnSurface);
      expect(scheme.onSurfaceVariant, WaColors.darkOnSurfaceVariant);
      expect(scheme.primaryContainer, WaColors.darkBubbleOut);
    });

    test('ThemeData is built once per brightness', () {
      expect(identical(AppTheme.light, AppTheme.light), isTrue);
      expect(identical(AppTheme.dark, AppTheme.dark), isTrue);
    });

    test('no font assets are bundled — the platform font is used', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();

      expect(
        RegExp(r'^\s{2}fonts:', multiLine: true).hasMatch(pubspec),
        isFalse,
        reason: 'WhatsApp uses the platform font on mobile; ship no fonts.',
      );
    });
  });

  group('contrast', () {
    test('body and button pairs meet WCAG AA (4.5:1)', () {
      for (final scheme in <ColorScheme>[
        AppTheme.light.colorScheme,
        AppTheme.dark.colorScheme,
      ]) {
        expect(_contrast(scheme.onSurface, scheme.surface), greaterThan(4.5));
        expect(_contrast(scheme.onPrimary, scheme.primary), greaterThan(4.5));
        expect(
          _contrast(scheme.onInverseSurface, scheme.inverseSurface),
          greaterThan(4.5),
        );
        expect(
          _contrast(scheme.onPrimaryContainer, scheme.primaryContainer),
          greaterThan(4.5),
        );
      }
    });

    test('muted text meets WCAG AA for large text (3:1)', () {
      for (final scheme in <ColorScheme>[
        AppTheme.light.colorScheme,
        AppTheme.dark.colorScheme,
      ]) {
        expect(
          _contrast(scheme.onSurfaceVariant, scheme.surface),
          greaterThan(3),
        );
        expect(_contrast(scheme.error, scheme.surface), greaterThan(3));
      }
    });

    test('brand green is fill-only — it fails as text on light surface', () {
      expect(
        _contrast(WaColors.brandGreen, WaColors.lightSurface),
        lessThan(4.5),
      );
    });
  });

  group('WaPalette', () {
    testWidgets('resolves by theme brightness', (tester) async {
      late WaPalette palette;
      Widget probe(ThemeData theme) {
        return MaterialApp(
          theme: theme,
          home: Builder(
            builder: (context) {
              palette = WaPalette.of(context);
              return const SizedBox.shrink();
            },
          ),
        );
      }

      await tester.pumpWidget(probe(AppTheme.light));
      await tester.pumpAndSettle();
      expect(palette, same(WaPalette.light));

      await tester.pumpWidget(probe(AppTheme.dark));
      await tester.pumpAndSettle();
      expect(palette, same(WaPalette.dark));
    });

    test('carries the chat wallpaper tones', () {
      expect(WaPalette.light.chatCanvas, WaColors.lightChatCanvas);
      expect(WaPalette.dark.chatCanvas, WaColors.darkChatCanvas);
    });
  });
}
