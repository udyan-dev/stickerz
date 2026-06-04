import 'package:flutter/material.dart';

import 'wa_colors.dart';

/// WhatsApp semantic (WDS) tokens that [ColorScheme] has no slot for.
///
/// Field names track the `--WDS-*` semantic token names one-for-one, so a value
/// can be checked against `docs/wds-tokens.tsv` without a mapping table.
/// Anything [ColorScheme] *does* cover (accent, surfaces, content, outlines) is
/// not duplicated here — read it from the theme.
///
/// Deliberately not a [ThemeExtension]: an extension pays for a `lerp`
/// allocation on every frame of a theme transition. Both variants are const, so
/// [of] is a brightness read plus a canonicalised const reference.
@immutable
class WaPalette {
  const WaPalette({
    required this.accentEmphasized,
    required this.surfaceElevated,
    required this.surfaceNavBar,
    required this.surfaceHighlight,
    required this.chatCanvas,
  });

  static const WaPalette light = WaPalette(
    accentEmphasized: WaColors.green700,
    surfaceElevated: WaColors.white,
    surfaceNavBar: WaColors.warmGray75,
    surfaceHighlight: WaColors.warmGray300Alpha15,
    chatCanvas: WaColors.cream85,
  );

  static const WaPalette dark = WaPalette(
    accentEmphasized: WaColors.green100,
    surfaceElevated: WaColors.neutralGray850,
    surfaceNavBar: WaColors.neutralGray850,
    surfaceHighlight: WaColors.whiteAlpha10,
    chatCanvas: WaColors.neutralGray900,
  );

  /// `accent-emphasized` — accent text/icons on an accent-tinted surface.
  final Color accentEmphasized;

  /// `surface-elevated-default` — sheets, dialogs, menus.
  final Color surfaceElevated;

  /// `components-surface-nav-bar` — bottom nav and system nav bar.
  final Color surfaceNavBar;

  /// `surface-highlight` — hover/selected list rows. Translucent.
  final Color surfaceHighlight;

  /// `systems-chat-background-wallpaper` — backdrop for sticker previews.
  final Color chatCanvas;

  static WaPalette of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}
