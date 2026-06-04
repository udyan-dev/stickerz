import 'dart:ui' show Color;

/// WhatsApp Design System (WDS) primitive colour ramps.
///
/// These are the raw palette steps WhatsApp ships today — extracted from the
/// `--WDS-*` custom properties in the WhatsApp Web stylesheet, which is the
/// same token set behind the 2024/2025 mobile redesign (warm neutrals, one
/// consistent green ramp, a one-shade-darker dark mode).
///
/// Only the steps the app actually paints are declared; the full ramps are in
/// `docs/wds-tokens.tsv`. Primitives are never used directly by widgets:
/// semantic tokens live in `WaPalette` and in the `ColorScheme`s built by
/// `AppTheme`. Nothing here is derived at runtime, so the whole palette
/// const-folds into the binary.
abstract final class WaColors {
  // Green — the single brand ramp. green400 is the logo/brand green.
  static const Color green100 = Color(0xFFD9FDD3);
  static const Color green300 = Color(0xFF71EB85);
  static const Color green400 = Color(0xFF25D366);
  static const Color green450 = Color(0xFF21C063);
  static const Color green500 = Color(0xFF1DAA61);
  static const Color green600 = Color(0xFF1B8755);
  static const Color green700 = Color(0xFF15603E);
  static const Color green800 = Color(0xFF103529);

  /// Published brand green (`WDS-green-400`). Fill only — 2:1 on white.
  static const Color brandGreen = green400;

  // Warm gray — light-mode neutrals. The 2024 redesign moved light mode off
  // the old cool blue-grays onto this warm ramp.
  static const Color warmGray75 = Color(0xFFF7F5F3);
  static const Color warmGray100 = Color(0xFFF1EEEB);
  static const Color warmGray200 = Color(0xFFDBD8D4);
  static const Color warmGray800 = Color(0xFF262524);

  // Neutral gray — dark-mode surfaces and shared content steps.
  static const Color neutralGray50 = Color(0xFFFAFAFA);
  static const Color neutralGray100 = Color(0xFFEEEEEE);
  static const Color neutralGray400 = Color(0xFF959393);
  static const Color neutralGray500 = Color(0xFF757778);
  static const Color neutralGray800 = Color(0xFF242626);
  static const Color neutralGray850 = Color(0xFF1D1F1F);
  static const Color neutralGray900 = Color(0xFF161717);
  static const Color neutralGray1000 = Color(0xFF0A0A0A);

  // Red — destructive/negative.
  static const Color red75 = Color(0xFFFDE8EB);
  static const Color red200 = Color(0xFFFA99A4);
  static const Color red300 = Color(0xFFFB5061);
  static const Color red400 = Color(0xFFEA0038);
  static const Color red500 = Color(0xFFB80531);
  static const Color red800 = Color(0xFF321622);

  /// Chat wallpaper (`WDS-systems-chat-background-wallpaper`, light).
  static const Color cream85 = Color(0xFFF5F1EB);

  static const Color white = Color(0xFFFFFFFF);

  // Alphas, as shipped.
  static const Color blackAlpha20 = Color(0x33000000);
  static const Color blackAlpha32 = Color(0x52000000);
  static const Color blackAlpha60 = Color(0x99000000);
  static const Color whiteAlpha10 = Color(0x1AFFFFFF);

  /// `surface-highlight`, light: warm-gray-300 (`#C2BDB8`) at 15%.
  static const Color warmGray300Alpha15 = Color(0x26C2BDB8);

  /// `content-deemphasized` flattened onto `surface-default`.
  ///
  /// WhatsApp ships this as `rgba(0,0,0,.6)` / `rgba(255,255,255,.6)`. The
  /// opaque equivalents are what `ColorScheme.onSurfaceVariant` needs: an alpha
  /// colour there composites twice over cards and bubbles and breaks contrast
  /// checks.
  static const Color lightContentDeemphasized = Color(0xFF666666);
  static const Color darkContentDeemphasized = Color(0xFFA2A2A2);

  /// `lines-divider` flattened onto `surface-default`.
  static const Color lightDivider = Color(0xFFE6E6E6);
  static const Color darkDivider = Color(0xFF2D2D2D);
}
