import 'dart:ui' show Color;

/// WhatsApp product colour tokens.
///
/// Values are the ones observable in shipping WhatsApp surfaces; the brand
/// green is the value published in Meta's brand resources. Nothing here is
/// derived at runtime, so the whole palette is const-folded into the binary.
class WaColors {
  const WaColors._();

  /// Published brand green. Fill only — 1.9:1 on white, never use as text.
  static const Color brandGreen = Color(0xFF25D366);

  // Light.
  static const Color lightPrimary = Color(0xFF008069);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF0F2F5);
  static const Color lightChatCanvas = Color(0xFFEFEAE2);
  static const Color lightBubbleOut = Color(0xFFD9FDD3);
  static const Color lightOnSurface = Color(0xFF111B21);
  static const Color lightOnSurfaceVariant = Color(0xFF667781);
  static const Color lightOutline = Color(0xFFD1D7DB);
  static const Color lightOutlineVariant = Color(0xFFE9EDEF);
  static const Color lightError = Color(0xFFDF3333);

  // Dark.
  static const Color darkPrimary = Color(0xFF00A884);
  static const Color darkSurface = Color(0xFF111B21);
  static const Color darkSurfaceContainer = Color(0xFF202C33);
  static const Color darkSurfaceContainerHigh = Color(0xFF2A3942);
  static const Color darkChatCanvas = Color(0xFF0B141A);
  static const Color darkBubbleOut = Color(0xFF005C4B);
  static const Color darkOnSurface = Color(0xFFE9EDEF);
  static const Color darkOnSurfaceVariant = Color(0xFF8696A0);
  static const Color darkOutline = Color(0xFF2A3942);
  static const Color darkOutlineVariant = Color(0xFF222D34);
  static const Color darkError = Color(0xFFF15C6D);

  static const Color white = Color(0xFFFFFFFF);
}
