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
  static const Color colorPrimary = Colors.blue;
  static const Color colorBackground = Color(0xFFF5F5F5);
  static const Color colorSurface = Colors.white;
  static const Color colorOnSurface = Colors.black87;
  static const Color colorDotInactive = Color(0xFF1A1C29);
  static const Color colorDotActive = Colors.blue;
  static const Color colorAccent = Colors.amber;

  // Typography
  static const TextStyle textDisplay = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: colorOnSurface,
    height: 1.2,
  );

  static const TextStyle textHeading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: colorPrimary,
    height: 1.3,
  );

  static const TextStyle textBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: colorOnSurface,
    height: 1.5,
  );

  // Timing (in milliseconds)
  static const int durationAnimationFast = 200;
  static const int durationAnimationStandard = 300;
  static const int durationAccessibilityDelay = 1500;
}
