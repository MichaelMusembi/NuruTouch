import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: localizationAsyncValue.when(
          data: (localizationService) => Column(
            children: [
              const Spacer(),
              Text(
                localizationService.getOnboarding('language_title'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(localeProvider.notifier).setLocale('english');
                  context.go('/orientation');
                },
                child: Text(localizationService.getOnboarding('language_english')),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(localeProvider.notifier).setLocale('swahili');
                  context.go('/orientation');
                },
                child: Text(localizationService.getOnboarding('language_swahili')),
              ),
              const Spacer(),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('Error loading translations')),
        )
      ),
    );
  }
}
