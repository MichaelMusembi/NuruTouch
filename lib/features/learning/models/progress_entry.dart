class ProgressEntry {
  final int? id;
  final String letter;
  final int masteryScore;
  final int attempts;
  final String lastReviewed;

  ProgressEntry({
    this.id,
    required this.letter,
    required this.masteryScore,
    required this.attempts,
    required this.lastReviewed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'letter': letter,
      'mastery_score': masteryScore,
      'attempts': attempts,
      'last_reviewed': lastReviewed,
    };
  }

  factory ProgressEntry.fromMap(Map<String, dynamic> map) {
    return ProgressEntry(
      id: map['id'],
      letter: map['letter'],
      masteryScore: map['mastery_score'],
      attempts: map['attempts'],
      lastReviewed: map['last_reviewed'],
    );
  }
}
