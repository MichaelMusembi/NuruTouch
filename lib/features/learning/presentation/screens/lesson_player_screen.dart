import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/services/audio_manager.dart';
import '../../../../core/services/haptic_language.dart';
import '../../../../core/services/voice_engine.dart';
import '../../services/curriculum_engine.dart';
import '../../services/teacher_amina_engine.dart';
import '../../services/adaptive_engine.dart';
import '../../repositories/learning_repository.dart';
import '../../models/progress_entry.dart';
import '../../models/lesson_state_machine.dart';
import '../widgets/blind_first_screen.dart';
import '../widgets/braille_grid_widget.dart';
import '../widgets/write_braille_widget.dart';

class LessonPlayerScreen extends BlindFirstScreen {
  const LessonPlayerScreen({super.key});

  void _handleInteractiveSuccess(WidgetRef ref, LessonPhase phase, int responseTimeMs) {
      final lessonId = ref.read(curriculumEngineProvider).currentLessonId;
      ref.read(adaptiveEngineProvider).updateQValue(
          letter: lessonId,
          state: phase.index,
          action: 0, // No hint
          reward: ref.read(adaptiveEngineProvider).calculateReward(true, responseTimeMs),
          nextState: phase.index + 1
      );
      ref.read(curriculumEngineProvider.notifier).advancePhase();
  }

  void _handleInteractiveFailure(WidgetRef ref, LessonPhase phase, int responseTimeMs) {
      final lessonId = ref.read(curriculumEngineProvider).currentLessonId;
      ref.read(adaptiveEngineProvider).updateQValue(
          letter: lessonId,
          state: phase.index,
          action: 0,
          reward: ref.read(adaptiveEngineProvider).calculateReward(false, responseTimeMs),
          nextState: phase.index // Stay in state
      );
  }

  void _handleDotTouched(BuildContext context, WidgetRef ref, int dotNumber) {
    final lessonState = ref.read(curriculumEngineProvider);
    final haptic = ref.read(hapticLanguageProvider);
    final audio = ref.read(audioManagerProvider);

    haptic.playNavigate();

    if (lessonState.currentPhase == LessonPhase.discover || lessonState.currentPhase == LessonPhase.recognition || lessonState.currentPhase == LessonPhase.quiz) {
      audio.play(AudioRequest(text: "Dot $dotNumber", priority: AudioPriority.high));
      if (dotNumber == 6) { // Mock discover complete
          audio.play(AudioRequest(text: "Excellent exploration."));
          _handleInteractiveSuccess(ref, lessonState.currentPhase, 1000);
      }
    } else if (lessonState.currentPhase == LessonPhase.masterDot) {
      if (dotNumber == 1) {
         haptic.playSuccess();
         audio.play(AudioRequest(text: "Wonderful! That's Dot One.", priority: AudioPriority.high));
         Future.delayed(const Duration(seconds: 2), () {
             _handleInteractiveSuccess(ref, lessonState.currentPhase, 1000);
         });
      } else {
         haptic.playError();
         audio.play(AudioRequest(text: "That's Dot $dotNumber. Keep looking for Dot One.", priority: AudioPriority.high));
         _handleInteractiveFailure(ref, lessonState.currentPhase, 1000);
      }
    }
  }

  void _handleWriteSubmission(BuildContext context, WidgetRef ref, List<int> dots) {
      final haptic = ref.read(hapticLanguageProvider);
      final audio = ref.read(audioManagerProvider);
      final phase = ref.read(curriculumEngineProvider).currentPhase;

      // Target for A is [1]
      if (dots.length == 1 && dots.first == 1) {
          haptic.playSuccess();
          audio.play(AudioRequest(text: "Perfect!", priority: AudioPriority.high));
          Future.delayed(const Duration(seconds: 2), () => _handleInteractiveSuccess(ref, phase, 2000));
      } else {
          haptic.playError();
          audio.play(AudioRequest(text: "Not quite. Remember, A is Dot One.", priority: AudioPriority.high));
          _handleInteractiveFailure(ref, phase, 2000);
      }
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(curriculumEngineProvider);

    ref.listen(curriculumEngineProvider, (previous, next) async {
       if (previous?.currentPhase != next.currentPhase && !next.isCompleted) {
           ref.read(teacherAminaEngineProvider).evaluateContextAndSpeak(next.currentPhase);

           if (next.currentPhase == LessonPhase.feel) {
               Future.delayed(const Duration(seconds: 2), () {
                   ref.read(hapticLanguageProvider).playLetterA();
                   // Auto advance Feel phase after pattern plays
                   Future.delayed(const Duration(seconds: 2), () {
                       ref.read(curriculumEngineProvider.notifier).advancePhase();
                   });
               });
           } else if (next.currentPhase == LessonPhase.welcome ||
                      next.currentPhase == LessonPhase.introduction ||
                      next.currentPhase == LessonPhase.listen ||
                      next.currentPhase == LessonPhase.review ||
                      next.currentPhase == LessonPhase.celebration ||
                      next.currentPhase == LessonPhase.dashboard) {
               // Non-interactive phases auto-advance after TTS simulated delay for MVP
               Future.delayed(const Duration(seconds: 4), () {
                   ref.read(curriculumEngineProvider.notifier).advancePhase();
               });
           } else if (next.currentPhase == LessonPhase.practice) {
               // ASR Mock Execution
               final engine = ref.read(voiceEngineProvider);
               await engine.initialize();
               final result = await engine.listen();
               if (result != null) {
                   ref.read(audioManagerProvider).play(AudioRequest(text: "I heard you!", priority: AudioPriority.high));
                   Future.delayed(const Duration(seconds: 2), () {
                       _handleInteractiveSuccess(ref, next.currentPhase, 1500);
                   });
               }
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
             child: _buildPhaseWidget(context, ref, lessonState.currentPhase),
           )
        ],
      ),
    );
  }

  Widget _buildPhaseWidget(BuildContext context, WidgetRef ref, LessonPhase phase) {
      if (phase == LessonPhase.discover || phase == LessonPhase.masterDot || phase == LessonPhase.recognition || phase == LessonPhase.quiz) {
          return BrailleGridWidget(
             onDotTouched: (dot) => _handleDotTouched(context, ref, dot),
             highlightedDots: phase == LessonPhase.masterDot ? [1] : [],
          );
      } else if (phase == LessonPhase.writing) {
          return WriteBrailleWidget(
             onSubmission: (dots) => _handleWriteSubmission(context, ref, dots)
          );
      } else if (phase == LessonPhase.practice) {
          return const Center(child: Icon(Icons.mic, size: 100, color: DesignTokens.colorDotActive));
      } else {
          return const Center(
             child: Text(
                "Listening Phase...",
                textAlign: TextAlign.center,
                style: DesignTokens.textBody
             ),
          );
      }
  }
}
