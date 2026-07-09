import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/router.dart';

void main() {
  runApp(const ProviderScope(child: NuruTouchApp()));
}

class NuruTouchApp extends StatelessWidget {
  const NuruTouchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NuruTouch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
