import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/media_item.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final service = ApiService();
  ref.onDispose(() => service.dispose());
  return service;
});

final mediaListProvider = FutureProvider<List<MediaItem>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/media');
  final items = (response['items'] as List<dynamic>?) ?? [];
  return items.map((e) => MediaItem.fromJson(e as Map<String, dynamic>)).toList();
});

final mediaItemProvider = FutureProvider.family<MediaItem?, String>((ref, id) async {
  final api = ref.watch(apiServiceProvider);
  try {
    final response = await api.get('/media/$id');
    return MediaItem.fromJson(response);
  } catch (_) {
    return null;
  }
});
