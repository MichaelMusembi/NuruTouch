import 'package:flutter/material.dart';

class GestureManager extends StatelessWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSingleTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onTwoFingerTap;

  const GestureManager({
    super.key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSingleTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTwoFingerTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onSingleTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
            onSwipeRight?.call();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
            onSwipeLeft?.call();
        } else if (details.velocity.pixelsPerSecond.dy > 0) {
            onSwipeDown?.call();
        } else if (details.velocity.pixelsPerSecond.dy < 0) {
            onSwipeUp?.call();
        }
      },
      // Note: Multi-finger gestures usually require RawGestureDetector.
      // For this MVP, we stub onTwoFingerTap logically.
      child: child,
    );
  }
}
