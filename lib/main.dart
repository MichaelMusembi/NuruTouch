import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/router.dart';
import 'core/design/design_tokens.dart';

void main() {
  runApp(const ProviderScope(child: NuruTouchApp()));
}

class NuruTouchApp extends ConsumerWidget {
  const NuruTouchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'NuruTouch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: DesignTokens.colorPrimary),
        scaffoldBackgroundColor: DesignTokens.colorBackground,
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: DesignTokens.textDisplay,
          headlineMedium: DesignTokens.textHeading,
          bodyLarge: DesignTokens.textBody,
        ),
      ),
      routerConfig: router,
    );
  }
}
