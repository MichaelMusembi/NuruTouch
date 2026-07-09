import 'package:vibration/vibration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hapticLanguageProvider = Provider<HapticLanguage>((ref) => HapticLanguage());

class HapticLanguage {
  static const int shortPulse = 120;
  static const int longPulse = 300;
  static const int gap = 150;

  Future<void> _vibrate(List<int> pattern) async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(pattern: pattern);
    }
  }

  Future<void> playSuccess() async {
    await _vibrate([0, shortPulse, gap, shortPulse, gap, longPulse]);
  }

  Future<void> playError() async {
    await _vibrate([0, longPulse, gap, longPulse]);
  }

  Future<void> playCelebrate() async {
    await _vibrate([0, shortPulse, gap, shortPulse, gap, shortPulse, gap, longPulse, gap, longPulse]);
  }

  Future<void> playHint() async {
    await _vibrate([0, shortPulse]);
  }

  Future<void> playWelcome() async {
    await _vibrate([0, longPulse, gap, shortPulse]);
  }

  Future<void> playNavigate() async {
    await _vibrate([0, 50]); // Very quick tap for navigation
  }

  Future<void> playWarning() async {
    await _vibrate([0, longPulse, gap, longPulse, gap, longPulse]);
  }

  // Example of dot encoding: A is dot 1
  Future<void> playLetterA() async {
    await _vibrate([0, shortPulse]);
  }
}
