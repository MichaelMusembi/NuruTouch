import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/localization_provider.dart';

// State model for the Curriculum Engine
class LessonState {
  final String currentLessonId;
  final int currentPhase;
  final bool isCompleted;

  LessonState({
    required this.currentLessonId,
    this.currentPhase = 1,
    this.isCompleted = false,
  });

  LessonState copyWith({String? currentLessonId, int? currentPhase, bool? isCompleted}) {
    return LessonState(
      currentLessonId: currentLessonId ?? this.currentLessonId,
      currentPhase: currentPhase ?? this.currentPhase,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class CurriculumEngine extends Notifier<LessonState> {
  @override
  LessonState build() {
    return LessonState(currentLessonId: 'lesson_a');
  }

  Future<void> startLesson(String lessonId) async {
    final locServiceAsync = ref.read(localizationServiceProvider);
    final locale = ref.read(localeProvider);

    // Load lesson data dynamically
    locServiceAsync.whenData((locService) async {
        await locService.loadLessonNarration(locale, lessonId);
        state = LessonState(currentLessonId: lessonId, currentPhase: 1);
    });
  }

  void advancePhase() {
    if (state.currentPhase < 16) {
      state = state.copyWith(currentPhase: state.currentPhase + 1);
    } else {
      state = state.copyWith(isCompleted: true);
    }
  }
}

final curriculumEngineProvider = NotifierProvider<CurriculumEngine, LessonState>(() {
  return CurriculumEngine();
});
