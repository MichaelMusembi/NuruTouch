import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../services/curriculum_engine.dart';
import '../../services/teacher_amina_engine.dart';
import '../../repositories/learning_repository.dart';
import '../../models/progress_entry.dart';
import '../widgets/blind_first_screen.dart';

class LessonPlayerScreen extends BlindFirstScreen {
  const LessonPlayerScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    ref.read(curriculumEngineProvider.notifier).advancePhase();
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(curriculumEngineProvider);

    // Initial injection. Trigger evaluation logic if phase just entered
    Future.microtask(() async {
        if (!lessonState.isCompleted) {
           ref.read(teacherAminaEngineProvider).evaluateContextAndSpeak(lessonState.currentPhase);
        } else {
           // Lesson is over, save progress and exit
           final repo = ref.read(learningRepositoryProvider);
           await repo.saveProgress(ProgressEntry(
               letter: lessonState.currentLessonId,
               masteryScore: 100, // Mock mastery bump
               attempts: 1,
               lastReviewed: DateTime.now().toIso8601String()
           ));

           if(context.mounted) {
              context.go('/learner/home');
           }
        }
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(lessonState.currentLessonId, style: DesignTokens.textDisplay),
           const SizedBox(height: DesignTokens.spaceMedium),
           Text(lessonState.currentPhase.name.toUpperCase(), style: DesignTokens.textHeading),
           const SizedBox(height: DesignTokens.spaceGiant),
           const Text("Swipe Right to Advance Phase", style: DesignTokens.textBody)
        ],
      ),
    );
  }
}
