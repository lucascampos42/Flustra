import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/media_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaAsync = ref.watch(mediaListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flustra')),
      body: mediaAsync.when(
        data: (mediaItems) {
          if (mediaItems.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma mídia encontrada no servidor.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(title: 'Biblioteca de Mídias', onSeeAll: () {}),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mediaItems.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final item = mediaItems[i];
                    return _MediaCard(
                      label: item.title,
                      onTap: () => context.go('/player/${item.id}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Erro ao carregar mídias: $err',
              style: const TextStyle(color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.go('/browse');
          if (i == 2) context.go('/search');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.library_music), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Browse'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          TextButton(onPressed: onSeeAll, child: const Text('See All')),
        ],
      ),
    );
  }
}

class _MediaCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MediaCard({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie, size: 40, color: Color(0xFF6C63FF)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
