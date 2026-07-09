import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/audio_manager.dart';
import '../../../core/localization/localization_provider.dart';
import '../models/lesson_state_machine.dart';

final teacherAminaEngineProvider = Provider<TeacherAminaEngine>((ref) {
  final audioManager = ref.watch(audioManagerProvider);
  return TeacherAminaEngine(audioManager, ref);
});

class TeacherAminaEngine {
  final AudioManager _audioManager;
  final Ref _ref;

  TeacherAminaEngine(this._audioManager, this._ref);

  Future<void> evaluateContextAndSpeak(LessonPhase phase, {Map<String, String>? variables, bool isError = false}) async {
    final localizationService = await _ref.read(localizationServiceProvider.future);

    String semanticKey = _determineKey(phase, isError: isError);
    String text;

    // Resolve dialogue vs narration
    if (isError) {
        text = localizationService.getDialogue(semanticKey, variables: variables);
    } else {
        text = localizationService.getNarration(semanticKey, variables: variables);
    }

    String locale = _ref.read(localeProvider) == 'swahili' ? 'sw-KE' : 'en-US';

    AudioPriority priority = isError ? AudioPriority.critical : AudioPriority.normal;

    _audioManager.play(AudioRequest(text: text, priority: priority, language: locale));
  }

  String _determineKey(LessonPhase phase, {bool isError = false}) {
    if (isError) return "retry";

    switch (phase) {
      case LessonPhase.welcome: return "phase_1_welcome";
      case LessonPhase.introduction: return "phase_2_intro";
      case LessonPhase.listen: return "phase_3_hear";
      case LessonPhase.feel: return "phase_4_feel";
      case LessonPhase.discover: return "phase_5_discover";
      case LessonPhase.masterDot: return "phase_6_mastery";
      case LessonPhase.practice: return "phase_10_practice";
      case LessonPhase.recognition: return "phase_9_recognition";
      case LessonPhase.writing: return "phase_7_build";
      case LessonPhase.quiz: return "phase_12_challenge";
      case LessonPhase.review: return "phase_14_reflection";
      case LessonPhase.celebration: return "phase_13_celebration";
      case LessonPhase.adaptiveUpdate: return "phase_16_dashboard";
      case LessonPhase.dashboard: return "phase_16_dashboard";
    }
  }
}
