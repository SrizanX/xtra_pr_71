import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design/design_system.dart';

/// Adaptive navigation scaffold hosting the five primary destinations from the
/// PR71 design: Home · Data · SMS · Devices · Settings.
///
/// Navigation follows Material's size guidance:
///
/// * phones — a bottom [NavigationBar];
/// * tablets — a side [NavigationRail] (icons + labels);
/// * large screens — an extended [NavigationRail] (icon + text, always shown).
///
/// Each tab is a [StatefulShellBranch] so its navigation state is preserved
/// when switching tabs.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = <_Destination>[
    _Destination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    _Destination(
      icon: Icons.contacts_outlined,
      selectedIcon: Icons.contacts,
      label: 'Contacts',
    ),
    _Destination(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      label: 'SMS',
    ),
    _Destination(
      icon: Icons.hub_outlined,
      selectedIcon: Icons.hub,
      label: 'Network',
    ),
    _Destination(
      icon: Icons.tune_outlined,
      selectedIcon: Icons.tune,
      label: 'Settings',
    ),
  ];

  void _onSelect(int index) {
    // Tapping the active tab again pops it back to its initial route.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.isTabletOrLarger) {
      return _RailScaffold(
        selectedIndex: navigationShell.currentIndex,
        onSelect: _onSelect,
        extended: context.deviceType == DeviceType.largeScreen,
        body: navigationShell,
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onSelect,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

/// Side-rail layout used on tablets and large screens.
class _RailScaffold extends StatelessWidget {
  const _RailScaffold({
    required this.selectedIndex,
    required this.onSelect,
    required this.extended,
    required this.body,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool extended;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelect,
              extended: extended,
              labelType: extended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: [
                for (final d in MainShell._destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
