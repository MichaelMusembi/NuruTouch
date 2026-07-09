import 'package:vibration/vibration.dart';

class HapticService {
  static const int shortPulse = 120;
  static const int longPulse = 300;
  static const int interPulseGap = 150;
  static const int structuralPause = 300;

  Future<void> playDotOne() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: shortPulse);
    }
  }

  Future<void> playDotTwo() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(
        pattern: [0, shortPulse, interPulseGap, shortPulse]
      );
    }
  }

  Future<void> playCustomPattern(List<int> pattern) async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
        Vibration.vibrate(pattern: pattern);
    }
  }
}
