import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/gesture_manager.dart';
import '../../../../core/services/haptic_language.dart';

abstract class BlindFirstScreen extends ConsumerWidget {
  const BlindFirstScreen({super.key});

  Widget buildContent(BuildContext context, WidgetRef ref);

  void onSwipeLeft(BuildContext context, WidgetRef ref) {}
  void onSwipeRight(BuildContext context, WidgetRef ref) {}
  void onSwipeUp(BuildContext context, WidgetRef ref) {}
  void onSwipeDown(BuildContext context, WidgetRef ref) {}
  void onSingleTap(BuildContext context, WidgetRef ref) {
    ref.read(hapticLanguageProvider).playNavigate();
  }
  void onDoubleTap(BuildContext context, WidgetRef ref) {}
  void onLongPress(BuildContext context, WidgetRef ref) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureManager(
        onSwipeLeft: () => onSwipeLeft(context, ref),
        onSwipeRight: () => onSwipeRight(context, ref),
        onSwipeUp: () => onSwipeUp(context, ref),
        onSwipeDown: () => onSwipeDown(context, ref),
        onSingleTap: () => onSingleTap(context, ref),
        onDoubleTap: () => onDoubleTap(context, ref),
        onLongPress: () => onLongPress(context, ref),
        child: buildContent(context, ref),
      ),
    );
  }
}
