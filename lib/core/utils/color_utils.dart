import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  // Colors for light theme
  static final List<Color> lightCardColors = [
    const Color(0xFF4CAF50).withOpacity(0.8), // Light Green
    const Color(0xFF2196F3).withOpacity(0.8), // Light Blue
    const Color(0xFFF44336).withOpacity(0.8), // Light Red
    const Color(0xFF9C27B0).withOpacity(0.8), // Light Purple
    const Color(0xFFFF9800).withOpacity(0.8), // Light Orange
    const Color(0xFF009688).withOpacity(0.8), // Light Teal
  ];

  // Colors for dark theme
  static final List<Color> darkCardColors = [
    const Color(0xFF81C784), // Dark Green
    const Color(0xFF64B5F6), // Dark Blue
    const Color(0xFFE57373), // Dark Red
    const Color(0xFFBA68C8), // Dark Purple
    const Color(0xFFFFB74D), // Dark Orange
    const Color(0xFF4DB6AC), // Dark Teal
  ];

  // Pastel colors for light theme
  static final List<Color> lightPastelColors = [
    const Color(0xFFFFF3F3), // Light Pastel Red
    const Color(0xFFF3F8FF), // Light Pastel Blue
    const Color(0xFFF3FFF3), // Light Pastel Green
    const Color(0xFFFFF8F3), // Light Pastel Orange
    const Color(0xFFFFF3FC), // Light Pastel Pink
    const Color(0xFFF3FCFF), // Light Pastel Cyan
  ];

  // Pastel colors for dark theme
  static final List<Color> darkPastelColors = [
    const Color(0xFF3D2B2E), // Dark Pastel Red
    const Color(0xFF2B323D), // Dark Pastel Blue
    const Color(0xFF2B3D2B), // Dark Pastel Green
    const Color(0xFF3D352B), // Dark Pastel Orange
    const Color(0xFF3D2B3A), // Dark Pastel Pink
    const Color(0xFF2B3A3D), // Dark Pastel Cyan
  ];

  static Color getRandomCardColor(BuildContext context) {
    final isDarkMode = checkIsDarkMode(context);
    final colors = isDarkMode ? darkCardColors : lightCardColors;
    return colors[Random().nextInt(colors.length)];
  }

  static Color getRandomPastelColor(BuildContext context) {
    final isDarkMode = checkIsDarkMode(context);
    final colors = isDarkMode ? darkPastelColors : lightPastelColors;
    return colors[Random().nextInt(colors.length)];
  }

  // Helper method to get current theme mode
  static bool checkIsDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
