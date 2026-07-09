import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/learning_repository.dart';
import '../models/q_table_entry.dart';

final adaptiveEngineProvider = Provider<AdaptiveEngine>((ref) {
  final repo = ref.watch(learningRepositoryProvider);
  return AdaptiveEngine(repo);
});

class AdaptiveEngine {
  final LearningRepository _repository;

  // Q-Learning constants
  static const double learningRate = 0.1; // Alpha
  static const double discountFactor = 0.9; // Gamma

  AdaptiveEngine(this._repository);

  /// Implements a basic Bellman Equation update for the Q-Table
  /// Q(s,a) = Q(s,a) + alpha * [Reward + gamma * max(Q(s',a')) - Q(s,a)]
  Future<void> updateQValue({
    required String letter,
    required int state, // e.g. 1 = Phase 6 (Mastery), 2 = Phase 10 (Practice)
    required int action, // e.g. 1 = Hint Given, 0 = No Hint
    required double reward, // e.g. +1 for correct, -1 for error, scaled by latency
    required int nextState,
  }) async {
    // 1. Fetch current Q-value
    final currentEntries = await _repository.getQTableForLetter(letter);

    QTableEntry? currentEntry;
    try {
        currentEntry = currentEntries.firstWhere((e) => e.state == state && e.action == action);
    } catch (_) {
        // Doesn't exist yet
    }

    double oldQ = currentEntry?.qValue ?? 0.0;

    // 2. Fetch max Q for next state
    double maxNextQ = 0.0;
    final nextStateEntries = currentEntries.where((e) => e.state == nextState);
    if (nextStateEntries.isNotEmpty) {
      maxNextQ = nextStateEntries.map((e) => e.qValue).reduce((a, b) => a > b ? a : b);
    }

    // 3. Bellman Equation
    double newQ = oldQ + learningRate * (reward + discountFactor * maxNextQ - oldQ);

    // 4. Save back to DB
    final updatedEntry = QTableEntry(
      id: currentEntry?.id, // Keep ID to update if it existed
      letter: letter,
      state: state,
      action: action,
      qValue: newQ,
    );

    await _repository.updateQValue(updatedEntry);
  }

  /// Calculates a reward value based on accuracy and hesitation (latency)
  double calculateReward(bool isCorrect, int responseTimeMs) {
     if (!isCorrect) return -1.0;

     // Optimal response time assumed < 2000ms. Decays after that.
     if (responseTimeMs < 2000) return 1.0;
     if (responseTimeMs < 5000) return 0.5;
     return 0.1; // Hesitated but correct
  }
}
