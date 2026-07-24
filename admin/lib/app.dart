import 'package:flutter/material.dart';
import 'core/flustra_theme.dart';
import 'core/router.dart';

class FlustraAdminApp extends StatelessWidget {
  const FlustraAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flustra Admin',
      theme: FlustraTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
