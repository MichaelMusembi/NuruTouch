import 'package:flutter/material.dart';

class DesignTokens {
  // Spacing
  static const double spaceSmall = 10.0;
  static const double spaceMedium = 20.0;
  static const double spaceLarge = 30.0;
  static const double spaceXLarge = 50.0;
  static const double spaceGiant = 80.0;

  // Touch Targets
  static const double touchTargetSmall = 48.0;
  static const double touchTargetStandard = 80.0;
  static const double touchTargetLarge = 120.0;

  // Colors
  static const Color colorPrimary = Color(0xFF1967D2); // Deep blue from screenshots
  static const Color colorBackground = Color(0xFFF8F9FA); // Off-white/light gray
  static const Color colorSurface = Colors.white;
  static const Color colorOnSurface = Color(0xFF111111); // Near black for text
  static const Color colorDotInactive = Color(0xFF171A21); // Dark blue/black for inactive dots
  static const Color colorDotActive = Color(0xFF1967D2);
  static const Color colorAccent = Color(0xFFFFC107); // Yellow for smiley/accent

  // Typography
  static const TextStyle textDisplay = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: colorOnSurface,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle textHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: colorPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle textBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF5F6368),
    height: 1.5,
  );

  // Timing (in milliseconds)
  static const int durationAnimationFast = 200;
  static const int durationAnimationStandard = 300;
  static const int durationAccessibilityDelay = 1500;
}
