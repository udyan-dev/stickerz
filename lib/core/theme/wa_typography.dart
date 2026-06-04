import 'package:flutter/material.dart';

/// One step on the type ramp's weight axis.
///
/// Pairs a [FontWeight] with its `wght` [FontVariation]: a variable face
/// ignores [TextStyle.fontWeight] on its own — the variation is what actually
/// moves it, while the weight still drives fallback metrics and `FontWeight`
/// arithmetic in widgets. Holding both in one const value makes it impossible
/// for them to disagree, and lets every style of a given weight share one list
/// instance, since `fontVariations` is compared identity-then-equality on each
/// text layout.
@immutable
class _Weight {
  const _Weight(this.weight, this.variations);

  static const _Weight regular = _Weight(FontWeight.w400, <FontVariation>[
    FontVariation('wght', 400),
  ]);
  static const _Weight medium = _Weight(FontWeight.w500, <FontVariation>[
    FontVariation('wght', 500),
  ]);
  static const _Weight semiBold = _Weight(FontWeight.w600, <FontVariation>[
    FontVariation('wght', 600),
  ]);
  static const _Weight bold = _Weight(FontWeight.w700, <FontVariation>[
    FontVariation('wght', 700),
  ]);

  final FontWeight weight;
  final List<FontVariation> variations;
}

/// WhatsApp's type ramp, on the bundled Roboto Variable asset.
///
/// Sizes, weights, line heights and tracking are the WDS type tokens as
/// shipped: 48/52, 28/32, 24/28, 15/19, 13/17, 11/16 at weights 400/500/600/700
/// with tracking 0.
///
/// **Family.** The WDS tokens name `Optimistic VF App Lite`, Meta's proprietary
/// variable family — it is not licensable, and WhatsApp does not serve it:
/// web.whatsapp.com ships two `@font-face` rules, both `Roboto Variable`
/// (`wght 100..900`, upright and italic). This app bundles the upstream Google
/// Fonts release of that same family, unmodified — `Roboto[wdth,wght].ttf` at
/// `assets/fonts/Roboto-Variable.ttf`, SIL OFL 1.1. Upright only, since the ramp
/// declares no italic style; `wdth` stays at its 100 default because no style
/// varies it.
abstract final class WaTypography {
  /// Family declared in `pubspec.yaml`.
  static const String fontFamily = 'Roboto';

  /// WDS tracking, at every step of the ramp.
  static const double tracking = 0;

  /// The ramp, resolved against a scheme's content colours.
  ///
  /// [color] is `content-default`, [muted] is `content-deemphasized`.
  static TextTheme textTheme({required Color color, required Color muted}) {
    // 48/52 w600 — onboarding and empty-state display.
    final display = _style(48, 52, _Weight.semiBold, color);
    // 28/32 w600 — large screen header.
    final headline = _style(28, 32, _Weight.semiBold, color);
    // 24/28 w600 — inbox header.
    final header = _style(24, 28, _Weight.semiBold, color);
    // 15/19 w500 — message text, primary body and buttons.
    final body = _style(15, 19, _Weight.medium, color);
    // 13/17 w400 — secondary body and list subtitle.
    final bodySecondary = _style(13, 17, _Weight.regular, muted);
    // 11/16 w400 — timestamps and captions.
    final caption = _style(11, 16, _Weight.regular, muted);

    return TextTheme(
      displayLarge: display,
      displayMedium: display,
      displaySmall: display,
      headlineLarge: headline,
      headlineMedium: headline,
      headlineSmall: header,
      titleLarge: header,
      // 15/19 w700 — list row title, dialog title.
      titleMedium: _style(15, 19, _Weight.bold, color),
      // 13/17 w700 — section header.
      titleSmall: _style(13, 17, _Weight.bold, color),
      bodyLarge: body,
      bodyMedium: bodySecondary,
      bodySmall: caption,
      labelLarge: body,
      // 11/16 w500 — nav labels, chips, badges.
      labelMedium: _style(11, 16, _Weight.medium, color),
      labelSmall: caption,
    );
  }

  static TextStyle _style(
    double size,
    double lineHeight,
    _Weight weight,
    Color color,
  ) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight.weight,
      fontVariations: weight.variations,
      letterSpacing: tracking,
      color: color,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }
}
