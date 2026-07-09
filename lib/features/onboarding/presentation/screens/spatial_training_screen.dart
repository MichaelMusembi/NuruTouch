import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class SpatialTrainingScreen extends BlindFirstScreen {
  const SpatialTrainingScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    context.go('/discover');
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return localizationAsyncValue.when(
      data: (localizationService) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: DesignTokens.colorPrimary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.explore, color: Colors.white, size: 60),
              ),
            ),
            const SizedBox(height: DesignTokens.spaceLarge),
            Text(
              localizationService.getOnboarding('spatial_title'),
              style: DesignTokens.textHeading,
            ),
            const SizedBox(height: DesignTokens.spaceMedium),
            const Text("Swipe Right to continue.", style: DesignTokens.textBody)
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error')),
    );
  }
}
