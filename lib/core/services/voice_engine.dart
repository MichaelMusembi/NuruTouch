import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class VoiceEngine {
  Future<void> initialize();
  Future<String?> listen();
}

class MockASR implements VoiceEngine {
  @override
  Future<void> initialize() async {
    // Mock setup
  }

  @override
  Future<String?> listen() async {
    // Stub implementation of ASR
    // Usually would fall back to UI tap input if it fails.
    await Future.delayed(const Duration(seconds: 2));
    return "mock_recognized_word";
  }
}

// In the future, you swap MockASR with SherpaOfflineASR here.
final voiceEngineProvider = Provider<VoiceEngine>((ref) => MockASR());
