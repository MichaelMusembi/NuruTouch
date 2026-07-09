import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_helper.dart';
import '../models/q_table_entry.dart';
import '../models/progress_entry.dart';

final learningRepositoryProvider = Provider<LearningRepository>((ref) {
  return LearningRepository(DatabaseHelper.instance);
});

class LearningRepository {
  final DatabaseHelper _dbHelper;

  LearningRepository(this._dbHelper);

  Future<void> updateQValue(QTableEntry entry) async {
    final db = await _dbHelper.database;
    await db.insert('q_table', entry.toMap(), conflictAlgorithm: (entry.id != null) ? null : null); // Simple abstraction for now
  }

  Future<List<QTableEntry>> getQTableForLetter(String letter) async {
    final db = await _dbHelper.database;
    final maps = await db.query('q_table', where: 'letter = ?', whereArgs: [letter]);
    return maps.map((map) => QTableEntry.fromMap(map)).toList();
  }

  Future<void> saveProgress(ProgressEntry entry) async {
    final db = await _dbHelper.database;
    await db.insert('progress', entry.toMap());
  }

  Future<ProgressEntry?> getProgress(String letter) async {
    final db = await _dbHelper.database;
    final maps = await db.query('progress', where: 'letter = ?', whereArgs: [letter]);
    if (maps.isNotEmpty) {
      return ProgressEntry.fromMap(maps.first);
    }
    return null;
  }
}
