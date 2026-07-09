class QTableEntry {
  final int? id;
  final String letter;
  final int state;
  final int action;
  final double qValue;

  QTableEntry({
    this.id,
    required this.letter,
    required this.state,
    required this.action,
    required this.qValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'letter': letter,
      'state': state,
      'action': action,
      'q_value': qValue,
    };
  }

  factory QTableEntry.fromMap(Map<String, dynamic> map) {
    return QTableEntry(
      id: map['id'],
      letter: map['letter'],
      state: map['state'],
      action: map['action'],
      qValue: map['q_value'],
    );
  }
}
