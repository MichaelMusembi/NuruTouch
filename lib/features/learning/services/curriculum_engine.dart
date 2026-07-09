import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/localization_provider.dart';
import '../models/lesson_state_machine.dart';

class CurriculumEngine extends Notifier<LessonState> {
  @override
  LessonState build() {
    return LessonState(currentLessonId: 'lesson_a');
  }

  Future<void> startLesson(String lessonId) async {
    final locale = ref.read(localeProvider);

    // Await the future directly to block execution until loaded
    final locService = await ref.read(localizationServiceProvider.future);

    await locService.loadLessonNarration(locale, lessonId);
    state = LessonState(currentLessonId: lessonId, currentPhase: LessonPhase.welcome);
  }

  void advancePhase() {
    if (state.currentPhase.index < LessonPhase.values.length - 1) {
      state = state.copyWith(currentPhase: LessonPhase.values[state.currentPhase.index + 1]);
    } else {
      state = state.copyWith(isCompleted: true);
    }
  }
}

final curriculumEngineProvider = NotifierProvider<CurriculumEngine, LessonState>(() {
  return CurriculumEngine();
});
