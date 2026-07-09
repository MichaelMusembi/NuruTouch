import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../services/session_manager.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionManagerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: DesignTokens.textHeading),
        backgroundColor: DesignTokens.colorSurface,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Learner ${sessionState.learnerId ?? ""}', style: DesignTokens.textDisplay),
            const SizedBox(height: DesignTokens.spaceGiant),
            SizedBox(
                width: 250,
                height: DesignTokens.touchTargetLarge,
                child: ElevatedButton(
                    onPressed: () {
                        // Load course definitions dynamically from JSON
                        ref.read(sessionManagerProvider.notifier).loadLesson('braille_foundations', 'unit_1_alphabet', 'lesson_a');
                        context.go('/learner/lesson');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: DesignTokens.colorPrimary),
                    child: const Text('Play Lesson A', style: TextStyle(color: Colors.white, fontSize: 24))
                )
            )
          ],
        ),
      ),
    );
  }
}
