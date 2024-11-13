import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  static final List<Color> cardColors = [
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFFF44336), // Red
    const Color(0xFF9C27B0), // Purple
    const Color(0xFFFF9800), // Orange
    const Color(0xFF009688), // Teal
  ];

  static final List<Color> pastelColors = [
    const Color(0xFFFFB3BA), // Pastel Red
    const Color(0xFFBAE1FF), // Pastel Blue
    const Color(0xFFBBFFB3), // Pastel Green
    const Color(0xFFFFDFBA), // Pastel Orange
    const Color(0xFFFFB3F7), // Pastel Pink
    const Color(0xFFB3F7FF), // Pastel Cyan
  ];

  static Color getRandomCardColor() {
    return cardColors[Random().nextInt(cardColors.length)];
  }

  static Color getRandomPastelColor() {
    return pastelColors[Random().nextInt(pastelColors.length)];
  }
}
