import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/tts_service.dart';
import '../../../core/localization/localization_provider.dart';

final teacherAminaProvider = Provider<TeacherAminaService>((ref) {
  final ttsService = TTSService();
  return TeacherAminaService(ttsService, ref);
});

class TeacherAminaService {
  final TTSService _ttsService;
  final Ref _ref;

  TeacherAminaService(this._ttsService, this._ref);

  Future<void> speakLessonNarration(String phaseKey, {Map<String, String>? variables}) async {
    final localizationAsync = _ref.read(localizationServiceProvider);

    localizationAsync.whenData((localizationService) {
        String text = localizationService.getNarration(phaseKey, variables: variables);
        String locale = _ref.read(localeProvider) == 'swahili' ? 'sw-KE' : 'en-US';
        _ttsService.speak(text, language: locale);
    });
  }
}
