import 'package:flutter/services.dart';

import 'wa_colors.dart';

/// Status-bar and navigation-bar styling for each theme.
///
/// The system nav bar takes `components-surface-nav-bar` (`#F7F5F3` /
/// `#1D1F1F`), not the scaffold surface: WhatsApp's own bottom nav sits on that
/// tone, and a mismatched system bar puts a visible seam under it.
///
/// Both variants are const, so applying one is a reference rather than the
/// relative-luminance maths `ThemeData.estimateBrightnessForColor` would run on
/// every rebuild of the app root.
abstract final class WaSystemUi {
  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: WaColors.warmGray75,
    systemNavigationBarDividerColor: WaColors.warmGray75,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
  );

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: WaColors.neutralGray850,
    systemNavigationBarDividerColor: WaColors.neutralGray850,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );
}
