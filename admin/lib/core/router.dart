import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/sidebar.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/logs/logs_screen.dart';
import '../features/users/users_screen.dart';
import '../features/plugins/plugins_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppShell(currentRoute: '/', child: DashboardScreen()),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const AppShell(currentRoute: '/settings', child: SettingsScreen()),
    ),
    GoRoute(
      path: '/logs',
      builder: (context, state) => const AppShell(currentRoute: '/logs', child: LogsScreen()),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const AppShell(currentRoute: '/users', child: UsersScreen()),
    ),
    GoRoute(
      path: '/plugins',
      builder: (context, state) => const AppShell(currentRoute: '/plugins', child: PluginsScreen()),
    ),
  ],
);
