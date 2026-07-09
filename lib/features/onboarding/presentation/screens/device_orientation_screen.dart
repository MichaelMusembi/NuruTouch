import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class DeviceOrientationScreen extends BlindFirstScreen {
  const DeviceOrientationScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    context.go('/spatial');
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
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                color: DesignTokens.colorPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.lock, color: Colors.white, size: 40),
              ),
            ),
            const SizedBox(height: DesignTokens.spaceLarge),
            Text(
              localizationService.getOnboarding('orientation_title'),
              style: DesignTokens.textHeading,
            ),
            const SizedBox(height: DesignTokens.spaceMedium),
            const Text("Hold phone portrait.\nSwipe Right to continue.", textAlign: TextAlign.center, style: DesignTokens.textBody)
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error')),
    );
  }
}
