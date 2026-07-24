import os

base = "/home/lucasc/development/Flustra/admin/lib"

# 1. Router
with open(f"{base}/core/router.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
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
""")

print("router.dart OK")

# 2. Dashboard
with open(f"{base}/features/dashboard/dashboard_screen.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../models/models.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statusAsync = ref.watch(statusProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 24),
            const SizedBox(width: 8),
            const Text('Dashboard'),
          ],
        ),
      ),
      body: statusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text('Could not connect to server', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 4),
              Text('${AppConstants.serverBaseUrl}', style: theme.textTheme.bodySmall),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => ref.invalidate(statusProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (status) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: status.status == 'running' ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(status.status.toUpperCase(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  Text('v${status.version}', style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Text('DB: ${status.dbType}', style: theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  children: [
                    _StatCard(
                      title: 'Uptime',
                      value: _formatUptime(status.uptimeSecs),
                      icon: Icons.timer,
                      color: Colors.purple,
                    ),
                    _StatCard(
                      title: 'Active Sessions',
                      value: '${status.activeSessions}',
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                    _StatCard(
                      title: 'Media Items',
                      value: '${status.mediaCount}',
                      icon: Icons.video_library,
                      color: Colors.orange,
                    ),
                    _StatCard(
                      title: 'Users',
                      value: '${status.userCount}',
                      icon: Icons.person,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatUptime(int secs) {
    final h = secs ~/ 3600;
    final m = (secs % 3600) ~/ 60;
    final s = secs % 60;
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 28),
            Text(value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(color: color, fontWeight: FontWeight.bold)),
            Text(title, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
""")

print("dashboard_screen.dart OK")

# 3. Settings
with open(f"{base}/features/settings/settings_screen.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final configAsync = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Server Settings')),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text('Failed to load config', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => ref.invalidate(configProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (config) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Connection', style: theme.textTheme.titleMedium),
                    const Divider(),
                    _ConfigRow(label: 'Server URL', value: AppConstants.serverBaseUrl),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Server Configuration', style: theme.textTheme.titleMedium),
                    const Divider(),
                    ...config.entries.map((e) => _ConfigRow(
                          label: e.key,
                          value: e.value.toString(),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigRow extends StatelessWidget {
  final String label;
  final String value;
  const _ConfigRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 13))),
        ],
      ),
    );
  }
}
""")

print("settings_screen.dart OK")

# 4. Logs
with open(f"{base}/features/logs/logs_screen.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class LogsScreen extends ConsumerStatefulWidget {
  const LogsScreen({super.key});

  @override
  ConsumerState<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends ConsumerState<LogsScreen> {
  String? _levelFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final params = LogQueryParams(level: _levelFilter, limit: 100);
    final logsAsync = ref.watch(logsProvider(params));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: _levelFilter,
              dropdownColor: theme.cardColor,
              hint: const Text('Level'),
              items: const [
                DropdownMenuItem(value: null, child: Text('All')),
                DropdownMenuItem(value: 'error', child: Text('ERROR')),
                DropdownMenuItem(value: 'warn', child: Text('WARN')),
                DropdownMenuItem(value: 'info', child: Text('INFO')),
                DropdownMenuItem(value: 'debug', child: Text('DEBUG')),
              ],
              onChanged: (v) => setState(() => _levelFilter = v),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(logsProvider(params)),
          ),
        ],
      ),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load logs: $e')),
        data: (logs) {
          if (logs.entries.isEmpty) {
            return const Center(child: Text('No log entries'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: logs.entries.length,
            itemBuilder: (context, i) {
              final entry = logs.entries[i];
              final color = entry.level == 'error'
                  ? Colors.red
                  : entry.level == 'warn'
                      ? Colors.orange
                      : Colors.grey;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(entry.timestamp.length > 8
                          ? entry.timestamp.substring(11, 19)
                          : entry.timestamp,
                          style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 48,
                      child: Text(entry.level.toUpperCase(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
                    ),
                    Expanded(
                      child: Text(entry.message, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
""")

print("logs_screen.dart OK")

# 5. Users
with open(f"{base}/features/users/users_screen.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(usersProvider),
          ),
        ],
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load users: $e')),
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: users.length,
            itemBuilder: (context, i) {
              final user = users[i];
              final roleColor = user.role == 'admin' ? Colors.red : Colors.blue;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: roleColor.withValues(alpha: 0.2),
                  child: Text(user.username[0].toUpperCase(),
                      style: TextStyle(color: roleColor, fontWeight: FontWeight.bold)),
                ),
                title: Text(user.username),
                subtitle: Text(user.id),
                trailing: Chip(
                  label: Text(user.role, style: const TextStyle(fontSize: 11, color: Colors.white)),
                  backgroundColor: roleColor.withValues(alpha: 0.3),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCreateDialog() {
    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    String role = 'viewer';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: usernameCtrl, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: passwordCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: role,
              decoration: const InputDecoration(labelText: 'Role'),
              items: const [
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
                DropdownMenuItem(value: 'viewer', child: Text('Viewer')),
              ],
              onChanged: (v) => role = v ?? 'viewer',
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              ref.read(apiServiceProvider).createUser(
                  usernameCtrl.text, passwordCtrl.text, role);
              Navigator.pop(ctx);
              ref.invalidate(usersProvider);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
""")

print("users_screen.dart OK")

# 6. Plugins
with open(f"{base}/features/plugins/plugins_screen.dart", "w") as f:
    f.write("""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../models/models.dart';

class PluginsScreen extends ConsumerWidget {
  const PluginsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pluginsAsync = ref.watch(pluginsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugins'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(pluginsProvider),
          ),
        ],
      ),
      body: pluginsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load plugins: $e')),
        data: (plugins) {
          if (plugins.isEmpty) {
            return const Center(child: Text('No plugins installed'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: plugins.length,
            itemBuilder: (context, i) {
              final plugin = plugins[i];
              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.extension,
                    color: plugin.enabled ? Colors.green : Colors.grey,
                  ),
                  title: Text(plugin.name),
                  subtitle: Text('v${plugin.version}'),
                  trailing: Switch(
                    value: plugin.enabled,
                    onChanged: (v) {
                      ref.read(apiServiceProvider).togglePlugin(plugin.name, v);
                      ref.invalidate(pluginsProvider);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
""")

print("plugins_screen.dart OK")
print("All screens generated!")