import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/wa_palette.dart';

/// Tray/sticker thumbnail on WhatsApp's chat-wallpaper tone, so transparent
/// WebP stickers read the same way they do inside a chat.
class LocalPackPreview extends StatelessWidget {
  const LocalPackPreview({
    required this.path,
    required this.fallbackIcon,
    this.dimension = 56,
    super.key,
  });

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(10));

  final String path;
  final IconData fallbackIcon;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: dimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: WaPalette.of(context).chatCanvas,
          borderRadius: _radius,
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: ClipRRect(
          borderRadius: _radius,
          child: path.isEmpty
              ? Icon(fallbackIcon, color: scheme.onSurfaceVariant)
              : Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  cacheWidth: (dimension * MediaQuery.devicePixelRatioOf(context))
                      .round(),
                  filterQuality: FilterQuality.medium,
                  errorBuilder: (_, _, _) {
                    return Icon(fallbackIcon, color: scheme.onSurfaceVariant);
                  },
                ),
        ),
      ),
    );
  }
}
