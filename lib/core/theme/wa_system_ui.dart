import 'package:flutter/services.dart';

import 'wa_colors.dart';

/// Status-bar and navigation-bar styling for each theme.
///
/// Precomputed consts: the previous implementation ran
/// `ThemeData.estimateBrightnessForColor` (relative-luminance maths) inside
/// `MaterialApp.builder`, i.e. on every rebuild of the app root.
class WaSystemUi {
  const WaSystemUi._();

  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: WaColors.lightSurface,
    systemNavigationBarDividerColor: WaColors.lightSurface,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
  );

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: WaColors.darkSurface,
    systemNavigationBarDividerColor: WaColors.darkSurface,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );

  static SystemUiOverlayStyle of(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}
