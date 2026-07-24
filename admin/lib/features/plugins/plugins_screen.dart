import 'package:flutter/material.dart';
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
