import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';

class SpatialTrainingScreen extends ConsumerWidget {
  const SpatialTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      body: InkWell(
        onTap: () => context.go('/discover'),
        child: localizationAsyncValue.when(
          data: (localizationService) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.explore, color: Colors.white, size: 60),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  localizationService.getOnboarding('spatial_title'),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('Error')),
        )
      ),
    );
  }
}
