import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class AdventureBeginsScreen extends BlindFirstScreen {
  const AdventureBeginsScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    context.go('/profile-setup');
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DesignTokens.colorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSmiley(),
            const SizedBox(height: 40),
            const Text(
              "Adventure Begins",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmiley() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: DesignTokens.colorAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: DesignTokens.colorAccent.withValues(alpha: 0.3),
            blurRadius: 50,
            spreadRadius: 15,
          )
        ]
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 60,
            left: 45,
            child: Container(width: 14, height: 14, decoration: const BoxDecoration(color: DesignTokens.colorDotInactive, shape: BoxShape.circle)),
          ),
          Positioned(
            top: 60,
            right: 45,
            child: Container(width: 14, height: 14, decoration: const BoxDecoration(color: DesignTokens.colorDotInactive, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}
