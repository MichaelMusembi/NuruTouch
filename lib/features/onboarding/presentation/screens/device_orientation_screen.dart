import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';

class DeviceOrientationScreen extends ConsumerWidget {
  const DeviceOrientationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      body: InkWell(
        onTap: () => context.go('/spatial'),
        child: localizationAsyncValue.when(
          data: (localizationService) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.lock, color: Colors.white, size: 40),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  localizationService.getOnboarding('orientation_title'),
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
