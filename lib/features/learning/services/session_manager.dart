import 'package:flutter_riverpod/flutter_riverpod.dart';

// State representing the active learning session orchestrator
class SessionState {
  final int? learnerId;
  final String? currentCourseId;
  final String? currentUnitId;
  final String? currentLessonId;
  final bool isPaused;

  SessionState({
    this.learnerId,
    this.currentCourseId,
    this.currentUnitId,
    this.currentLessonId,
    this.isPaused = false,
  });

  SessionState copyWith({
    int? learnerId,
    String? currentCourseId,
    String? currentUnitId,
    String? currentLessonId,
    bool? isPaused,
  }) {
    return SessionState(
      learnerId: learnerId ?? this.learnerId,
      currentCourseId: currentCourseId ?? this.currentCourseId,
      currentUnitId: currentUnitId ?? this.currentUnitId,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

class SessionManager extends Notifier<SessionState> {
  @override
  SessionState build() {
    return SessionState();
  }

  void startSession(int learnerId) {
    state = state.copyWith(learnerId: learnerId);
    // Logic to Auto Save / Recovery from DB would be triggered here
  }

  void loadLesson(String courseId, String unitId, String lessonId) {
    state = state.copyWith(
      currentCourseId: courseId,
      currentUnitId: unitId,
      currentLessonId: lessonId,
      isPaused: false,
    );
  }

  void pause() {
    state = state.copyWith(isPaused: true);
  }

  void resume() {
    state = state.copyWith(isPaused: false);
  }

  void exitSession() {
    state = SessionState(); // Reset
  }
}

final sessionManagerProvider = NotifierProvider<SessionManager, SessionState>(() {
  return SessionManager();
});
