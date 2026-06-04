import 'package:flutter/material.dart';

/// One destination in [WaBottomNav].
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
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
    final foreground = isSelected
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;

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
                size: 22,
                color: foreground,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              destination.label,
              style: TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? scheme.onSurface : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
