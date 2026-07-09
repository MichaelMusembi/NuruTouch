import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class LanguageSelectionScreen extends BlindFirstScreen {
  const LanguageSelectionScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    ref.read(localeProvider.notifier).setLocale('english');
    context.go('/orientation');
  }

  @override
  void onSwipeLeft(BuildContext context, WidgetRef ref) {
    super.onSwipeLeft(context, ref);
    ref.read(localeProvider.notifier).setLocale('swahili');
    context.go('/orientation');
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return SafeArea(
      child: localizationAsyncValue.when(
        data: (localizationService) => Column(
          children: [
            const Spacer(),
            Text(
              localizationService.getOnboarding('language_title'),
              style: DesignTokens.textDisplay,
            ),
            const SizedBox(height: DesignTokens.spaceGiant),
            const Text(
               'Swipe Right for English\nSwipe Left for Kiswahili',
               textAlign: TextAlign.center,
               style: DesignTokens.textBody,
            ),
            const Spacer(),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error loading translations')),
      )
    );
  }
}
