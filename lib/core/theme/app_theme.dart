import 'package:flutter/material.dart';

import 'wa_colors.dart';
import 'wa_icons.dart';
import 'wa_palette.dart';
import 'wa_typography.dart';

/// WhatsApp light/dark themes, on the current (2024/2025) WDS palette.
///
/// Both [ColorScheme]s are written out by hand rather than seeded: a seeded
/// scheme runs HCT tonal-palette maths at startup and produces ~60 colours,
/// none of which are WhatsApp's. Both [ThemeData]s are `static final`, so the
/// tree is built once per process instead of once per `MaterialApp` rebuild.
///
/// Mapping from WDS semantic tokens to Material slots:
///
/// | Material slot        | WDS token                       |
/// |----------------------|---------------------------------|
/// | primary              | `accent`                        |
/// | onPrimary            | `content-on-accent`             |
/// | primaryContainer     | `accent-deemphasized`           |
/// | onPrimaryContainer   | `accent-emphasized`             |
/// | tertiary             | `persistent-activity-indicator` |
/// | surface              | `surface-default`               |
/// | surfaceContainer     | `surface-emphasized`            |
/// | surfaceContainerHigh | `surface-elevated-emphasized`   |
/// | onSurface            | `content-default`               |
/// | onSurfaceVariant     | `content-deemphasized` (opaque) |
/// | outline              | `lines-outline-default`         |
/// | outlineVariant       | `lines-divider` (opaque)        |
/// | inverseSurface       | `surface-inverse`               |
/// | error                | `secondary-negative`            |
///
/// `onSurfaceVariant` and `outlineVariant` take flattened opaque equivalents:
/// WhatsApp ships those two as alpha-on-surface, which composites twice once
/// Material paints them over cards and bubbles.
///
/// Type comes from the bundled variable font in `assets/fonts`: see
/// [WaTypography] (Roboto Variable, the family WhatsApp Web itself serves).
/// Icons come from Material's bundled icon font: see [WaIcons].
abstract final class AppTheme {
  /// WDS corner radii.
  static const double _radiusSmall = 8;
  static const double _radius = 12;
  static const double _radiusSheet = 28;
  static const double _fabRadius = 16;

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: WaColors.green500,
    onPrimary: WaColors.white,
    primaryContainer: WaColors.green100,
    onPrimaryContainer: WaColors.green700,
    secondary: WaColors.green600,
    onSecondary: WaColors.white,
    secondaryContainer: WaColors.warmGray75,
    onSecondaryContainer: WaColors.neutralGray1000,
    tertiary: WaColors.brandGreen,
    onTertiary: WaColors.neutralGray1000,
    error: WaColors.red400,
    onError: WaColors.white,
    errorContainer: WaColors.red75,
    onErrorContainer: WaColors.red500,
    surface: WaColors.white,
    onSurface: WaColors.neutralGray1000,
    surfaceContainerLowest: WaColors.white,
    surfaceContainerLow: WaColors.white,
    surfaceContainer: WaColors.warmGray75,
    surfaceContainerHigh: WaColors.warmGray100,
    surfaceContainerHighest: WaColors.warmGray200,
    onSurfaceVariant: WaColors.lightContentDeemphasized,
    outline: WaColors.neutralGray400,
    outlineVariant: WaColors.lightDivider,
    inverseSurface: WaColors.warmGray800,
    onInverseSurface: WaColors.white,
    inversePrimary: WaColors.green450,
    shadow: WaColors.blackAlpha20,
    scrim: WaColors.blackAlpha32,
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: WaColors.green450,
    onPrimary: WaColors.neutralGray1000,
    primaryContainer: WaColors.green800,
    onPrimaryContainer: WaColors.green100,
    secondary: WaColors.green300,
    onSecondary: WaColors.neutralGray1000,
    secondaryContainer: WaColors.neutralGray850,
    onSecondaryContainer: WaColors.neutralGray50,
    tertiary: WaColors.brandGreen,
    onTertiary: WaColors.neutralGray1000,
    error: WaColors.red300,
    onError: WaColors.neutralGray1000,
    errorContainer: WaColors.red800,
    onErrorContainer: WaColors.red200,
    surface: WaColors.neutralGray900,
    onSurface: WaColors.neutralGray50,
    surfaceContainerLowest: WaColors.neutralGray1000,
    surfaceContainerLow: WaColors.neutralGray900,
    surfaceContainer: WaColors.neutralGray850,
    surfaceContainerHigh: WaColors.neutralGray800,
    surfaceContainerHighest: WaColors.neutralGray800,
    onSurfaceVariant: WaColors.darkContentDeemphasized,
    outline: WaColors.neutralGray500,
    outlineVariant: WaColors.darkDivider,
    inverseSurface: WaColors.neutralGray100,
    onInverseSurface: WaColors.neutralGray1000,
    inversePrimary: WaColors.green500,
    shadow: WaColors.blackAlpha60,
    scrim: WaColors.blackAlpha32,
  );

  static final ThemeData light = _build(_lightScheme, WaPalette.light);
  static final ThemeData dark = _build(_darkScheme, WaPalette.dark);

  static ThemeData _build(ColorScheme scheme, WaPalette palette) {
    final borderRadius = BorderRadius.circular(_radius);
    final inputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: scheme.outline),
    );
    final textTheme = WaTypography.textTheme(
      color: scheme.onSurface,
      muted: scheme.onSurfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      fontFamily: WaTypography.fontFamily,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        // WhatsApp's inbox header: 24/28 w600.
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: IconThemeData(
          color: scheme.onSurface,
          size: WaIconSize.standard,
        ),
        actionsIconTheme: IconThemeData(
          color: scheme.onSurface,
          size: WaIconSize.standard,
        ),
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: palette.surfaceNavBar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 64,
        padding: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        focusElevation: 2,
        hoverElevation: 2,
        highlightElevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_fabRadius)),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodyMedium,
        selectedColor: scheme.onPrimaryContainer,
        selectedTileColor: palette.surfaceHighlight,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      iconTheme: IconThemeData(
        color: scheme.onSurface,
        size: WaIconSize.standard,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(64, 48),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.accentEmphasized,
          minimumSize: const Size(64, 44),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.accentEmphasized,
          minimumSize: const Size(64, 48),
          side: BorderSide(color: scheme.outline),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: scheme.error),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        labelStyle: textTheme.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusSheet),
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontSize: 18,
          height: 24 / 18,
        ),
        contentTextStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onInverseSurface,
        ),
        actionTextColor: scheme.inversePrimary,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: palette.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: textTheme.bodyLarge,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        showDragHandle: true,
        dragHandleColor: scheme.outline,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_radiusSheet),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        circularTrackColor: Colors.transparent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainer,
        selectedColor: scheme.primaryContainer,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
        shape: const StadiumBorder(),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(_radiusSmall),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
    );
  }
}
