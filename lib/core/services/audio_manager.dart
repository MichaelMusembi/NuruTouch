import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tts_service.dart';

enum AudioPriority {
  low,      // Background, non-essential
  normal,   // Standard narration
  high,     // Button presses, immediate feedback
  critical  // Interrupts everything (errors, warnings)
}

class AudioRequest {
  final String text;
  final AudioPriority priority;
  final String language;

  AudioRequest({required this.text, this.priority = AudioPriority.normal, this.language = "en-US"});
}

final audioManagerProvider = Provider<AudioManager>((ref) {
  final ttsService = TTSService();
  return AudioManager(ttsService);
});

class AudioManager {
  final TTSService _ttsService;
  final Queue<AudioRequest> _queue = Queue<AudioRequest>();
  bool _isPlaying = false;
  AudioRequest? _currentRequest;

  AudioManager(this._ttsService);

  Future<void> play(AudioRequest request) async {
    if (request.priority == AudioPriority.critical || request.priority == AudioPriority.high) {
      // High priority interrupts current
      _queue.clear();
      await _ttsService.stop();
      _isPlaying = false;
    }

    _queue.add(request);
    _processQueue();
  }

  Future<void> _processQueue() async {
    if (_isPlaying || _queue.isEmpty) return;

    _isPlaying = true;
    _currentRequest = _queue.removeFirst();

    await _ttsService.speak(_currentRequest!.text, language: _currentRequest!.language);
    // In a real implementation with TTS completion callbacks, we'd wait for the TTS to finish.
    // For now, we simulate completion based on text length (mock).
    await Future.delayed(Duration(milliseconds: 100 * _currentRequest!.text.length));

    _isPlaying = false;
    _currentRequest = null;
    _processQueue();
  }

  Future<void> stop() async {
    _queue.clear();
    await _ttsService.stop();
    _isPlaying = false;
    _currentRequest = null;
  }
}
