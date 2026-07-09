import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/localization_provider.dart';

class DiscoverDotsScreen extends ConsumerWidget {
  const DiscoverDotsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: localizationAsyncValue.when(
          data: (loc) => Text(loc.getOnboarding('discover_title'), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          loading: () => const Text('...'),
          error: (_,__) => const Text('Error'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFF1a1c29),
        shape: BoxShape.circle,
      ),
    );
  }
}
