import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/presentation/widgets/blind_first_screen.dart';

class GestureTutorialScreen extends BlindFirstScreen {
  final bool isSwipeTutorial;

  const GestureTutorialScreen({super.key, this.isSwipeTutorial = false});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    if (isSwipeTutorial) {
       context.go('/voice-enrollment');
    }
  }

  @override
  void onSingleTap(BuildContext context, WidgetRef ref) {
    super.onSingleTap(context, ref);
    if (!isSwipeTutorial) {
       context.go('/gesture-swipe');
    }
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isSwipeTutorial) ...[
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 _buildTopDash(true),
                 const SizedBox(width: 8),
                 _buildTopDash(true),
                 const SizedBox(width: 8),
                 _buildTopDash(true),
               ],
             ),
             const Spacer(),
             Container(
               width: 80,
               height: 80,
               decoration: const BoxDecoration(
                 color: DesignTokens.colorPrimary,
                 shape: BoxShape.circle,
               ),
               child: Center(
                 child: Container(
                   width: 50,
                   height: 50,
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.white, width: 2),
                     shape: BoxShape.circle,
                   ),
                 ),
               ),
             ),
             const SizedBox(height: 50),
             const Text("Tap once → hear again", style: DesignTokens.textDisplay),
             const SizedBox(height: 10),
             const Text("Bonyeza → sikia tena", style: DesignTokens.textBody),
             const Spacer(),
          ] else ...[
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 _buildTopDash(true),
                 const SizedBox(width: 8),
                 _buildTopDash(false),
                 const SizedBox(width: 8),
                 _buildTopDash(false),
               ],
             ),
             const Spacer(),
             const Icon(Icons.arrow_forward, size: 80, color: DesignTokens.colorPrimary),
             const SizedBox(height: 50),
             const Text("Swipe right → go forward", style: DesignTokens.textDisplay),
             const SizedBox(height: 10),
             const Text("Telezesha kulia → mbele", style: DesignTokens.textBody),
             const Spacer(),
          ]
        ],
      ),
    );
  }

  Widget _buildTopDash(bool active) {
    return Container(
      width: 40,
      height: 6,
      decoration: BoxDecoration(
        color: active ? DesignTokens.colorPrimary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
