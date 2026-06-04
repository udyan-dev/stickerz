import 'package:flutter/material.dart';

/// Glyph box sizes, as WhatsApp ships them.
///
/// [standard] is the theme-wide default (`ThemeData.iconTheme.size`); the other
/// two are for the places WhatsApp deviates from it.
abstract final class WaIconSize {
  /// WhatsApp's default 24dp glyph box.
  static const double standard = 24;

  /// Bottom-nav destination glyph.
  static const double nav = 22;

  /// Inline glyph next to 13/17 text — dense buttons, error rows.
  static const double small = 20;
}

/// The app's icon vocabulary, as Material [IconData] from the icon font that
/// `uses-material-design: true` already bundles.
///
/// WhatsApp's post-2024 glyphs are rounded, outlined artwork drawn in-house and
/// served from authenticated app chunks — not published, and not ours to
/// redistribute. Material's `_rounded` and `_outlined` variants are the closest
/// published match on the same 24dp grid, and cost no bundled asset: a release
/// build tree-shakes the icon font down to the code points named here.
///
/// Draw one with [Icon], which resolves colour and size from the ambient
/// [IconTheme]. Only nav destinations have a selected state, so only they pair
/// an outlined glyph with a filled one.
///
/// Every entry is referenced by a widget; add one when a screen needs it rather
/// than ahead of time.
abstract final class WaIcons {
  // Navigation.
  static const IconData stickers = Icons.mood_outlined;
  static const IconData stickersFilled = Icons.mood_rounded;
  static const IconData store = Icons.storefront_outlined;
  static const IconData storeFilled = Icons.storefront_rounded;

  // Actions.
  static const IconData add = Icons.add_rounded;
  static const IconData addImage = Icons.add_photo_alternate_outlined;
  static const IconData gallery = Icons.photo_library_outlined;
  static const IconData crop = Icons.crop_square_rounded;
  static const IconData resize = Icons.photo_size_select_small_outlined;
  static const IconData forward = Icons.chevron_right_rounded;

  // Status.
  static const IconData info = Icons.info_outline_rounded;
  static const IconData warning = Icons.warning_amber_rounded;
  static const IconData sticker = Icons.sticky_note_2_outlined;
}
