import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const AppShell({super.key, required this.currentRoute, required this.child});

  static const _navItems = [
    ('/', 'Dashboard', Icons.dashboard),
    ('/users', 'Users', Icons.people),
    ('/logs', 'Logs', Icons.list_alt),
    ('/plugins', 'Plugins', Icons.extension),
    ('/settings', 'Settings', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _navItems.indexWhere((n) => n.$1 == currentRoute),
            onDestinationSelected: (i) {
              final route = _navItems[i].$1;
              if (route != currentRoute) {
                Navigator.of(context).pushReplacementNamed(route);
              }
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset('assets/logo.png', height: 36),
            ),
            destinations: _navItems
                .map((n) => NavigationRailDestination(
                      icon: Icon(n.$3),
                      label: Text(n.$2),
                    ))
                .toList(),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
