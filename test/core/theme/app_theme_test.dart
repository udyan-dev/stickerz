import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stickerz/core/theme/app_theme.dart';
import 'package:stickerz/core/theme/wa_colors.dart';
import 'package:stickerz/core/theme/wa_icons.dart';
import 'package:stickerz/core/theme/wa_palette.dart';
import 'package:stickerz/core/theme/wa_typography.dart';

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
    test('light scheme carries the WDS light values', () {
      final scheme = AppTheme.light.colorScheme;

      expect(scheme.brightness, Brightness.light);
      // accent / content-on-accent.
      expect(scheme.primary, WaColors.green500);
      expect(scheme.onPrimary, WaColors.white);
      // accent-deemphasized / accent-emphasized.
      expect(scheme.primaryContainer, WaColors.green100);
      expect(scheme.onPrimaryContainer, WaColors.green700);
      // surface-default / surface-emphasized — warm neutrals, not cool.
      expect(scheme.surface, WaColors.white);
      expect(scheme.surfaceContainer, WaColors.warmGray75);
      expect(scheme.onSurface, WaColors.neutralGray1000);
      expect(scheme.onSurfaceVariant, WaColors.lightContentDeemphasized);
      expect(scheme.error, WaColors.red400);
    });

    test('dark scheme carries the WDS dark values', () {
      final scheme = AppTheme.dark.colorScheme;

      expect(scheme.brightness, Brightness.dark);
      expect(scheme.primary, WaColors.green450);
      expect(scheme.onPrimary, WaColors.neutralGray1000);
      expect(scheme.primaryContainer, WaColors.green800);
      expect(scheme.onPrimaryContainer, WaColors.green100);
      // The 2024 "one shade darker" dark mode: #161717 / #1D1F1F / #242626.
      expect(scheme.surface, WaColors.neutralGray900);
      expect(scheme.surfaceContainer, WaColors.neutralGray850);
      expect(scheme.surfaceContainerHigh, WaColors.neutralGray800);
      expect(scheme.onSurface, WaColors.neutralGray50);
      expect(scheme.onSurfaceVariant, WaColors.darkContentDeemphasized);
      expect(scheme.error, WaColors.red300);
    });

    test('ThemeData is built once per brightness', () {
      expect(identical(AppTheme.light, AppTheme.light), isTrue);
      expect(identical(AppTheme.dark, AppTheme.dark), isTrue);
    });

    test('the text font family is declared and bundled', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();

      expect(
        RegExp(r'^\s{2}fonts:', multiLine: true).hasMatch(pubspec),
        isTrue,
      );
      expect(pubspec, contains('family: ${WaTypography.fontFamily}'));

      for (final asset in <String>['assets/fonts/Roboto-Variable.ttf']) {
        expect(pubspec, contains(asset));
        final file = File(asset);
        expect(file.existsSync(), isTrue, reason: '$asset is missing');
        expect(file.lengthSync(), greaterThan(1024));
      }
    });

    test('the font licence ships next to the asset', () {
      expect(File('assets/fonts/Roboto-OFL.txt').existsSync(), isTrue);
    });
  });

  group('typography', () {
    test('carries the WDS type ramp', () {
      final text = AppTheme.light.textTheme;

      // 15/19 w500 body, 13/17 w400 secondary, 11/16 caption, 24/28 header.
      expect(text.bodyLarge!.fontSize, 15);
      expect(text.bodyLarge!.fontWeight, FontWeight.w500);
      expect(text.bodyLarge!.height, 19 / 15);
      expect(text.bodyMedium!.fontSize, 13);
      expect(text.bodyMedium!.fontWeight, FontWeight.w400);
      expect(text.bodySmall!.fontSize, 11);
      expect(text.headlineSmall!.fontSize, 24);
      expect(text.headlineSmall!.fontWeight, FontWeight.w600);
      expect(text.titleMedium!.fontWeight, FontWeight.w700);
    });

    test('every step names the bundled family and drives the wght axis', () {
      final ramp = WaTypography.textTheme(
        color: WaColors.neutralGray1000,
        muted: WaColors.neutralGray500,
      );

      for (final style in <TextStyle?>[
        ramp.displaySmall,
        ramp.headlineLarge,
        ramp.headlineSmall,
        ramp.titleMedium,
        ramp.titleSmall,
        ramp.bodyLarge,
        ramp.bodyMedium,
        ramp.bodySmall,
        ramp.labelLarge,
        ramp.labelMedium,
        ramp.labelSmall,
      ]) {
        expect(style!.letterSpacing, WaTypography.tracking);
        expect(style.fontFamily, WaTypography.fontFamily);
        // A variable face ignores fontWeight alone: the wght variation is what
        // actually moves it, so the two must agree at every step.
        expect(style.fontVariations, <FontVariation>[
          FontVariation('wght', style.fontWeight!.value.toDouble()),
        ]);
      }
    });

    test('weight variations are shared const instances', () {
      final a = WaTypography.textTheme(
        color: WaColors.neutralGray1000,
        muted: WaColors.neutralGray500,
      );
      final b = WaTypography.textTheme(
        color: WaColors.white,
        muted: WaColors.neutralGray500,
      );

      expect(a.bodyLarge!.fontVariations, same(b.labelLarge!.fontVariations));
    });

    test('the app bar uses the inbox header style', () {
      // Compared field-wise: ThemeData merges its own typography into
      // `textTheme`, which adds a debug label the raw ramp style has not got.
      final title = AppTheme.light.appBarTheme.titleTextStyle!;
      final header = AppTheme.light.textTheme.headlineSmall!;

      expect(title.fontSize, header.fontSize);
      expect(title.fontWeight, header.fontWeight);
      expect(title.height, header.height);
      expect(title.letterSpacing, header.letterSpacing);
    });
  });

  group('WaIcons', () {
    test('no icon asset or icon font is bundled', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();

      expect(pubspec, contains('uses-material-design: true'));
      expect(pubspec, isNot(contains('assets/icons')));
      expect(Directory('assets/icons').existsSync(), isFalse);
      expect(
        Directory('assets/fonts').listSync().map((entry) => entry.path),
        everyElement(isNot(contains('Symbols'))),
      );
    });

    test('navigation destinations pair an outlined and a filled glyph', () {
      expect(WaIcons.stickers, isNot(WaIcons.stickersFilled));
      expect(WaIcons.store, isNot(WaIcons.storeFilled));
    });

    test('every glyph comes from the Material icon font', () {
      for (final icon in <IconData>[
        WaIcons.stickers,
        WaIcons.stickersFilled,
        WaIcons.store,
        WaIcons.storeFilled,
        WaIcons.add,
        WaIcons.addImage,
        WaIcons.gallery,
        WaIcons.crop,
        WaIcons.resize,
        WaIcons.forward,
        WaIcons.info,
        WaIcons.warning,
        WaIcons.sticker,
      ]) {
        expect(icon.fontFamily, 'MaterialIcons');
        expect(icon.fontPackage, isNull);
      }
    });

    test('the icon theme sizes glyphs at 24dp', () {
      for (final theme in <ThemeData>[AppTheme.light, AppTheme.dark]) {
        expect(theme.iconTheme.size, WaIconSize.standard);
      }
    });
  });

  group('contrast', () {
    test('body text pairs meet WCAG AA (4.5:1)', () {
      for (final scheme in <ColorScheme>[
        AppTheme.light.colorScheme,
        AppTheme.dark.colorScheme,
      ]) {
        expect(_contrast(scheme.onSurface, scheme.surface), greaterThan(4.5));
        expect(
          _contrast(scheme.onInverseSurface, scheme.inverseSurface),
          greaterThan(4.5),
        );
        expect(
          _contrast(scheme.onPrimaryContainer, scheme.primaryContainer),
          greaterThan(4.5),
        );
        expect(
          _contrast(scheme.onSurfaceVariant, scheme.surface),
          greaterThan(4.5),
        );
      }
    });

    test('accent fill meets AA for large text/icons (3:1)', () {
      // WhatsApp ships white on #1DAA61 (3.0:1) — below AA for small text.
      // Accent is used as a fill behind icons and 15px+ w500 labels, and
      // `accentEmphasized` (#15603E / #D9FDD3) carries accent *text*.
      for (final scheme in <ColorScheme>[
        AppTheme.light.colorScheme,
        AppTheme.dark.colorScheme,
      ]) {
        expect(_contrast(scheme.onPrimary, scheme.primary), greaterThan(3));
      }
      expect(
        _contrast(
          WaPalette.light.accentEmphasized,
          AppTheme.light.colorScheme.surface,
        ),
        greaterThan(4.5),
      );
      expect(
        _contrast(
          WaPalette.dark.accentEmphasized,
          AppTheme.dark.colorScheme.surface,
        ),
        greaterThan(4.5),
      );
    });

    test('error meets WCAG AA for large text (3:1)', () {
      for (final scheme in <ColorScheme>[
        AppTheme.light.colorScheme,
        AppTheme.dark.colorScheme,
      ]) {
        expect(_contrast(scheme.error, scheme.surface), greaterThan(3));
      }
    });

    test('brand green is fill-only — it fails as text on light surface', () {
      expect(_contrast(WaColors.brandGreen, WaColors.white), lessThan(4.5));
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

    test('carries the WDS tones ColorScheme has no slot for', () {
      expect(WaPalette.light.chatCanvas, WaColors.cream85);
      expect(WaPalette.dark.chatCanvas, WaColors.neutralGray900);
      expect(WaPalette.light.surfaceNavBar, WaColors.warmGray75);
      expect(WaPalette.dark.surfaceNavBar, WaColors.neutralGray850);
      expect(WaPalette.light.surfaceElevated, WaColors.white);
      expect(WaPalette.dark.surfaceElevated, WaColors.neutralGray850);
    });
  });
}
