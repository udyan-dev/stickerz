import 'package:flutter/material.dart';

import 'wa_colors.dart';

/// WhatsApp colours that [ColorScheme] has no slot for.
///
/// Deliberately not a [ThemeExtension]: an extension pays for a `lerp`
/// allocation on every frame of a theme transition. Both variants are const,
/// so [of] is a brightness read plus a canonicalised const reference.
@immutable
class WaPalette {
  const WaPalette({
    required this.brandGreen,
    required this.chatCanvas,
    required this.badge,
  });

  /// Brand green. Fill only, never text on a light surface.
  final Color brandGreen;

  /// Chat wallpaper tone — backdrop for sticker previews.
  final Color chatCanvas;

  /// Unread/count badge fill. White foreground in both modes.
  final Color badge;

  static const WaPalette light = WaPalette(
    brandGreen: WaColors.brandGreen,
    chatCanvas: WaColors.lightChatCanvas,
    badge: WaColors.brandGreen,
  );

  static const WaPalette dark = WaPalette(
    brandGreen: WaColors.brandGreen,
    chatCanvas: WaColors.darkChatCanvas,
    badge: WaColors.darkPrimary,
  );

  static WaPalette of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}
