import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'core/flustra_theme.dart';

class FlustraApp extends ConsumerWidget {
  const FlustraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flustra',
      theme: flustraTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
