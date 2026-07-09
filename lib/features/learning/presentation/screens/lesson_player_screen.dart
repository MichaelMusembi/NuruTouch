import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/services/audio_manager.dart';
import '../../../../core/services/haptic_language.dart';
import '../../services/curriculum_engine.dart';
import '../../services/teacher_amina_engine.dart';
import '../../repositories/learning_repository.dart';
import '../../models/progress_entry.dart';
import '../../models/lesson_state_machine.dart';
import '../widgets/blind_first_screen.dart';
import '../widgets/braille_grid_widget.dart';

class LessonPlayerScreen extends BlindFirstScreen {
  const LessonPlayerScreen({super.key});

  @override
  void onSwipeRight(BuildContext context, WidgetRef ref) {
    super.onSwipeRight(context, ref);
    // Remove auto-advance debug logic. Phase transitions should be handled by actual interaction success.
    // For MVP slice, we will still allow swipe right as an explicit "Next" command for non-interactive phases.
    final currentPhase = ref.read(curriculumEngineProvider).currentPhase;
    if (currentPhase == LessonPhase.welcome ||
        currentPhase == LessonPhase.introduction ||
        currentPhase == LessonPhase.listen ||
        currentPhase == LessonPhase.feel) {
       ref.read(curriculumEngineProvider.notifier).advancePhase();
    }
  }

  void _handleDotTouched(BuildContext context, WidgetRef ref, int dotNumber) {
    final lessonState = ref.read(curriculumEngineProvider);
    final haptic = ref.read(hapticLanguageProvider);
    final audio = ref.read(audioManagerProvider);

    haptic.playNavigate();

    if (lessonState.currentPhase == LessonPhase.discover) {
      // In discover phase, Teacher Amina announces every dot touched.
      audio.play(AudioRequest(
         text: "Dot $dotNumber",
         priority: AudioPriority.high // Interrupts ongoing speech
      ));

      // We simulate mastery of the discover phase after 3 dots are touched (mock logic)
      // In reality, this should be tracked in a state notifier
      if (dotNumber == 6) {
          audio.play(AudioRequest(text: "Excellent exploration."));
          ref.read(curriculumEngineProvider.notifier).advancePhase();
      }
    } else if (lessonState.currentPhase == LessonPhase.masterDot) {
      // Assume the target is Dot 1 for Lesson A
      if (dotNumber == 1) {
         haptic.playSuccess();
         audio.play(AudioRequest(text: "Wonderful! That's Dot One.", priority: AudioPriority.high));
         Future.delayed(const Duration(seconds: 2), () {
             ref.read(curriculumEngineProvider.notifier).advancePhase();
         });
      } else {
         haptic.playError();
         audio.play(AudioRequest(text: "That's Dot $dotNumber. Keep looking for Dot One.", priority: AudioPriority.high));
      }
    }
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(curriculumEngineProvider);

    ref.listen(curriculumEngineProvider, (previous, next) async {
       if (previous?.currentPhase != next.currentPhase && !next.isCompleted) {
           // Provide narration for the new phase
           ref.read(teacherAminaEngineProvider).evaluateContextAndSpeak(next.currentPhase);

           // If phase is 'Feel', trigger haptic pattern for Letter A
           if (next.currentPhase == LessonPhase.feel) {
               Future.delayed(const Duration(seconds: 2), () {
                   ref.read(hapticLanguageProvider).playLetterA();
               });
           }

       } else if (next.isCompleted) {
           final repo = ref.read(learningRepositoryProvider);
           await repo.saveProgress(ProgressEntry(
               letter: next.currentLessonId,
               masteryScore: 100,
               attempts: 1,
               lastReviewed: DateTime.now().toIso8601String()
           ));

           if(context.mounted) {
              context.go('/learner/home');
           }
       }
    });

    return SafeArea(
      child: Column(
        children: [
           Padding(
             padding: const EdgeInsets.all(DesignTokens.spaceMedium),
             child: Text(
                 "${lessonState.currentLessonId} - ${lessonState.currentPhase.name.toUpperCase()}",
                 style: DesignTokens.textHeading
             ),
           ),
           Expanded(
             child: (lessonState.currentPhase == LessonPhase.discover || lessonState.currentPhase == LessonPhase.masterDot)
               ? BrailleGridWidget(
                   onDotTouched: (dot) => _handleDotTouched(context, ref, dot),
                   highlightedDots: lessonState.currentPhase == LessonPhase.masterDot ? [1] : [],
                 )
               : Center(
                   child: Text(
                      "Listening/Feeling Phase...\n(Swipe Right to Continue)",
                      textAlign: TextAlign.center,
                      style: DesignTokens.textBody
                   ),
                 ),
           )
        ],
      ),
    );
  }
}
