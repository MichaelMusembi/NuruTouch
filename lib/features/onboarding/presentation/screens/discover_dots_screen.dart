import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';
import '../../../../core/services/haptic_language.dart';

class DiscoverDotsScreen extends BlindFirstScreen {
  const DiscoverDotsScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    context.go('/profile-setup');
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: localizationAsyncValue.when(
          data: (loc) => Text(loc.getOnboarding('discover_title'), style: DesignTokens.textHeading),
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
                _buildDot(context, ref, 1),
                _buildDot(context, ref, 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(context, ref, 2),
                _buildDot(context, ref, 5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(context, ref, 3),
                _buildDot(context, ref, 6),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(BuildContext context, WidgetRef ref, int dotNumber) {
    return GestureDetector(
      onTap: () {
          ref.read(hapticLanguageProvider).playNavigate();
          // In a real app we'd announce "Dot $dotNumber" here via AudioManager
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: DesignTokens.colorDotInactive,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
