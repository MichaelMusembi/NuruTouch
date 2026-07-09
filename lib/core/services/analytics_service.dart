import 'package:flutter_riverpod/flutter_riverpod.dart';

// Represents local events to be emitted. In reality, these go to SQLite.
class AnalyticsEvent {
  final String eventName;
  final Map<String, dynamic> payload;
  final DateTime timestamp;

  AnalyticsEvent(this.eventName, this.payload) : timestamp = DateTime.now();
}

final analyticsProvider = Provider<AnalyticsService>((ref) => AnalyticsService());

class AnalyticsService {
  void track(String eventName, {Map<String, dynamic>? properties}) {
    // For MVP, we stub this out. In production, insert into an analytics_events SQLite table.
    // ignore: unused_local_variable
    final event = AnalyticsEvent(eventName, properties ?? {});
  }
}
