import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/library/library_screen.dart';
import '../features/browse/browse_screen.dart';
import '../features/search/search_screen.dart';
import '../features/player/player_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, _) => const LibraryScreen()),
      GoRoute(path: '/browse', builder: (_, _) => const BrowseScreen()),
      GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
      GoRoute(
        path: '/player/:id',
        builder: (_, state) => PlayerScreen(id: state.pathParameters['id']!),
      ),
    ],
  );
});
