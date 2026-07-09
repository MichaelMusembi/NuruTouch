import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Use NotifierProvider in riverpod 3.x
class LocaleNotifier extends Notifier<String> {
  @override
  String build() => 'english';

  void setLocale(String locale) {
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, String>(() => LocaleNotifier());

// We use FutureProvider to handle async initialization.
final localizationServiceProvider = FutureProvider<LocalizationService>((ref) async {
  final locale = ref.watch(localeProvider);
  final service = LocalizationService();
  await service.loadLanguage(locale);
  return service;
});

class LocalizationService {
  Map<String, String> _dialogues = {};
  Map<String, String> _lessonNarration = {};
  Map<String, String> _onboarding = {};

  Future<void> loadLanguage(String localeCode) async {
    try {
      final dialogueString = await rootBundle.loadString('assets/localization/$localeCode/teacher_dialogue.json');
      _dialogues = Map<String, String>.from(json.decode(dialogueString));

      final onboardingString = await rootBundle.loadString('assets/localization/$localeCode/onboarding.json');
      _onboarding = Map<String, String>.from(json.decode(onboardingString));
    } catch (e) {
      // Intentionally ignoring print for now.
    }
  }

  // Called dynamically when entering a lesson.
  Future<void> loadLessonNarration(String localeCode, String lessonId) async {
    try {
      final narrationString = await rootBundle.loadString('assets/localization/$localeCode/${lessonId}_narration.json');
      _lessonNarration = Map<String, String>.from(json.decode(narrationString));
    } catch (e) {
      // Intentionally ignoring
    }
  }

  String getDialogue(String key, {Map<String, String>? variables}) {
    String text = _dialogues[key] ?? key;
    if (variables != null) {
      variables.forEach((k, v) {
        text = text.replaceAll('{$k}', v);
      });
    }
    return text;
  }

  String getNarration(String key, {Map<String, String>? variables}) {
    String text = _lessonNarration[key] ?? key;
    if (variables != null) {
      variables.forEach((k, v) {
        text = text.replaceAll('{$k}', v);
      });
    }
    return text;
  }

  String getOnboarding(String key, {Map<String, String>? variables}) {
    String text = _onboarding[key] ?? key;
    if (variables != null) {
      variables.forEach((k, v) {
        text = text.replaceAll('{$k}', v);
      });
    }
    return text;
  }
}
