import 'package:flutter/material.dart';

import '../../../core/theme/wa_icons.dart';
import '../../../core/theme/wa_palette.dart';

/// One destination in [WaBottomNav].
///
/// [selectedIcon] is the filled counterpart of [icon], so the two states stay
/// in register on the same glyph.
@immutable
class WaNavDestination {
  const WaNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// WhatsApp's bottom navigation bar: hairline on top, a filled pill behind the
/// selected icon, label always visible.
///
/// Hand-rolled rather than [NavigationBar] because Material's version animates
/// an indicator and a label opacity per destination on every selection change;
/// WhatsApp's swaps instantly and this keeps the widget const-heavy.
class WaBottomNav extends StatelessWidget {
  const WaBottomNav({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  static const double _height = 60;
  static const double _pillWidth = 56;
  static const double _pillHeight = 32;

  final List<WaNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: WaPalette.of(context).surfaceNavBar,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _height,
          child: Row(
            children: <Widget>[
              for (var index = 0; index < destinations.length; index++)
                Expanded(
                  child: _WaNavItem(
                    destination: destinations[index],
                    isSelected: index == selectedIndex,
                    onTap: () => onDestinationSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaNavItem extends StatelessWidget {
  const _WaNavItem({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final WaNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: isSelected ? null : onTap,
      customBorder: const StadiumBorder(),
      child: Semantics(
        selected: isSelected,
        button: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: WaBottomNav._pillWidth,
              height: WaBottomNav._pillHeight,
              alignment: Alignment.center,
              decoration: isSelected
                  ? ShapeDecoration(
                      color: scheme.primaryContainer,
                      shape: const StadiumBorder(),
                    )
                  : null,
              child: Icon(
                isSelected ? destination.selectedIcon : destination.icon,
                size: WaIconSize.nav,
                color: isSelected
                    ? scheme.onPrimaryContainer
                    : scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              destination.label,
              // WDS 11/16, w500 selected / w400 unselected. Taken as whole ramp
              // steps rather than a `copyWith(fontWeight:)`: on a variable face
              // only the `wght` variation moves the weight, and the ramp already
              // carries a matched pair at this size.
              style: isSelected
                  ? theme.textTheme.labelMedium
                  : theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
