import 'package:flutter/material.dart';

class PluginsScreen extends StatelessWidget {
  const PluginsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugins')),
      body: const Center(child: Text('Plugins - Flustra Admin')),
    );
  }
}
