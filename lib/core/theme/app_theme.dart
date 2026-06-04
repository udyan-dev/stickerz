import 'package:flutter/material.dart';

import 'wa_colors.dart';

/// WhatsApp light/dark themes.
///
/// Both [ColorScheme]s are written out by hand rather than seeded: a seeded
/// scheme runs HCT tonal-palette maths at startup and produces ~60 colours,
/// none of which are WhatsApp's. Both [ThemeData]s are `static final`, so the
/// tree is built once per process instead of once per `MaterialApp` rebuild.
///
/// No `fontFamily` is set anywhere: WhatsApp uses the platform font on mobile
/// (Roboto / SF Pro), so the app ships no font assets.
class AppTheme {
  const AppTheme._();

  static const double _radius = 12;
  static const double _pillRadius = 28;
  static const double _fabRadius = 16;

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: WaColors.lightPrimary,
    onPrimary: WaColors.white,
    primaryContainer: WaColors.lightBubbleOut,
    onPrimaryContainer: WaColors.lightOnSurface,
    secondary: WaColors.lightPrimary,
    onSecondary: WaColors.white,
    secondaryContainer: WaColors.lightSurfaceContainer,
    onSecondaryContainer: WaColors.lightOnSurface,
    tertiary: WaColors.brandGreen,
    onTertiary: WaColors.white,
    error: WaColors.lightError,
    onError: WaColors.white,
    surface: WaColors.lightSurface,
    onSurface: WaColors.lightOnSurface,
    surfaceContainerLowest: WaColors.lightSurface,
    surfaceContainerLow: WaColors.lightSurface,
    surfaceContainer: WaColors.lightSurfaceContainer,
    surfaceContainerHigh: WaColors.lightSurfaceContainer,
    surfaceContainerHighest: WaColors.lightSurfaceContainer,
    onSurfaceVariant: WaColors.lightOnSurfaceVariant,
    outline: WaColors.lightOutline,
    outlineVariant: WaColors.lightOutlineVariant,
    inverseSurface: WaColors.lightOnSurface,
    onInverseSurface: WaColors.darkOnSurface,
    inversePrimary: WaColors.darkPrimary,
    shadow: Color(0x33000000),
    scrim: Color(0x99000000),
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: WaColors.darkPrimary,
    onPrimary: WaColors.darkSurface,
    primaryContainer: WaColors.darkBubbleOut,
    onPrimaryContainer: WaColors.darkOnSurface,
    secondary: WaColors.darkPrimary,
    onSecondary: WaColors.darkSurface,
    secondaryContainer: WaColors.darkSurfaceContainerHigh,
    onSecondaryContainer: WaColors.darkOnSurface,
    tertiary: WaColors.brandGreen,
    onTertiary: WaColors.darkSurface,
    error: WaColors.darkError,
    onError: WaColors.darkSurface,
    surface: WaColors.darkSurface,
    onSurface: WaColors.darkOnSurface,
    surfaceContainerLowest: WaColors.darkChatCanvas,
    surfaceContainerLow: WaColors.darkSurface,
    surfaceContainer: WaColors.darkSurfaceContainer,
    surfaceContainerHigh: WaColors.darkSurfaceContainerHigh,
    surfaceContainerHighest: WaColors.darkSurfaceContainerHigh,
    onSurfaceVariant: WaColors.darkOnSurfaceVariant,
    outline: WaColors.darkOutline,
    outlineVariant: WaColors.darkOutlineVariant,
    inverseSurface: WaColors.darkOnSurface,
    onInverseSurface: WaColors.darkSurface,
    inversePrimary: WaColors.lightPrimary,
    shadow: Color(0x66000000),
    scrim: Color(0xB3000000),
  );

  static final ThemeData light = _build(_lightScheme);
  static final ThemeData dark = _build(_darkScheme);

  static ThemeData _build(ColorScheme scheme) {
    final borderRadius = BorderRadius.circular(_radius);
    final inputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: scheme.outline),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
        actionsIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: scheme.surface,
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
        subtitleTextStyle: TextStyle(
          color: scheme.onSurfaceVariant,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(64, 48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(64, 44),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(64, 48),
          side: BorderSide(color: scheme.primary),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_pillRadius),
        ),
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 15),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface, fontSize: 14),
        actionTextColor: scheme.inversePrimary,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: TextStyle(color: scheme.onSurface, fontSize: 15),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        showDragHandle: true,
        dragHandleColor: scheme.outline,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_pillRadius)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        circularTrackColor: Colors.transparent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainer,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: TextStyle(color: scheme.onSurface, fontSize: 13),
        shape: const StadiumBorder(),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(color: scheme.onInverseSurface, fontSize: 13),
      ),
    );
  }
}
