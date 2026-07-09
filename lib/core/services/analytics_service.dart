import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_helper.dart';

final analyticsProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService(DatabaseHelper.instance);
});

class AnalyticsService {
  final DatabaseHelper _db;

  AnalyticsService(this._db);

  Future<void> logEvent(String eventName, {Map<String, dynamic>? payload, int? sessionId, int? learnerId}) async {
    final db = await _db.database;
    await db.insert('analytics_events', {
      'event_name': eventName,
      'payload': payload != null ? jsonEncode(payload) : '{}',
      'timestamp': DateTime.now().toIso8601String(),
      'session_id': sessionId,
      'learner_id': learnerId,
    });
  }
}
