import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const primary = Color(0xFF6200EE);
  static const secondary = Color(0xFF03DAC6);
  static const error = Color(0xFFB00020);

  // Action colors
  static const like = Color(0xFF4CAF50);
  static const pass = Color(0xFFF44336);
  static const superLike = Color(0xFF2196F3);
  static const boost = Color(0xFF9C27B0);

  // Neutral colors
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const onBackground = Color(0xFF000000);
  static const onSurface = Color(0xFF000000);

  // Text colors
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF666666);
  static const textHint = Color(0xFF999999);

  // Status colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const info = Color(0xFF2196F3);

  // Social colors
  static const facebook = Color(0xFF1877F2);
  static const google = Color(0xFFDB4437);
  static const apple = Color(0xFF000000);

  // Gradient colors
  static const gradientStart = Color(0xFF6200EE);
  static const gradientEnd = Color(0xFF9C27B0);

  // Dark theme colors
  static const darkPrimary = Color(0xFFBB86FC);
  static const darkSecondary = Color(0xFF03DAC6);
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkError = Color(0xFFCF6679);

  // Light theme colors
  static const lightPrimary = Color(0xFF6200EE);
  static const lightSecondary = Color(0xFF03DAC6);
  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightError = Color(0xFFB00020);

  // Opacity values
  static const opacity12 = 0.12;
  static const opacity38 = 0.38;
  static const opacity54 = 0.54;
  static const opacity87 = 0.87;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black54],
  );

  // Color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
