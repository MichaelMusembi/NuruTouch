import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class VoiceEnrollmentScreen extends BlindFirstScreen {
  const VoiceEnrollmentScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    context.go('/adventure-begins');
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Text(
              "Learn your voice",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: DesignTokens.colorDotInactive,
                letterSpacing: -1,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: DesignTokens.colorPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: DesignTokens.colorPrimary.withValues(alpha: 0.2),
                  blurRadius: 40,
                  spreadRadius: 10,
                )
              ]
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDotIndicator(true),
              const SizedBox(width: 12),
              _buildDotIndicator(false),
              const SizedBox(width: 12),
              _buildDotIndicator(false),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Round 1 of 3", style: DesignTokens.textBody),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(bool active) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? DesignTokens.colorPrimary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: active ? DesignTokens.colorPrimary : Colors.grey.shade300, width: 2),
      ),
    );
  }
}
