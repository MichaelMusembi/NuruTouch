enum LessonPhase {
  welcome,
  introduction,
  listen,
  feel,
  discover,
  masterDot,
  practice,
  recognition,
  writing,
  quiz,
  review,
  celebration,
  adaptiveUpdate,
  dashboard
}

class LessonState {
  final String currentLessonId;
  final LessonPhase currentPhase;
  final bool isCompleted;

  LessonState({
    required this.currentLessonId,
    this.currentPhase = LessonPhase.welcome,
    this.isCompleted = false,
  });

  LessonState copyWith({String? currentLessonId, LessonPhase? currentPhase, bool? isCompleted}) {
    return LessonState(
      currentLessonId: currentLessonId ?? this.currentLessonId,
      currentPhase: currentPhase ?? this.currentPhase,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
