import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../learning/services/session_manager.dart';

class LearnerProfileScreen extends ConsumerWidget {
  const LearnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Profile',
                style: DesignTokens.textDisplay,
              ),
              const SizedBox(height: DesignTokens.spaceXLarge),
              SizedBox(
                 width: double.infinity,
                 height: DesignTokens.touchTargetStandard,
                 child: ElevatedButton(
                    onPressed: () {
                        // Mock DB profile creation -> Learner ID 1
                        ref.read(sessionManagerProvider.notifier).startSession(1);
                        context.go('/learner/home');
                    },
                    child: const Text('Start Adventure (Learner 1)', style: DesignTokens.textBody)
                 )
              )
            ],
          ),
        ),
      ),
    );
  }
}
