import 'package:flutter/material.dart';
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
