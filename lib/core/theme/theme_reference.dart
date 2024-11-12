import 'package:flutter/material.dart';

/// Light Theme Reference Guide
/// Quick reference for light theme
class LightThemeReference {
  LightThemeReference._();

  /// COLORS REFERENCE
  /// --------------------------------------------------
  static const primary = Color(0xFF36618E); // Main color
  static const onPrimary = Color(0xFFFFFFFF); // Text on primary
  static const primaryContainer = Color(0xFFD1E4FF); // Primary container
  static const onPrimaryContainer =
      Color(0xFF001D36); // Text on primary container

  static const secondary = Color(0xFF535F70); // Secondary color
  static const onSecondary = Color(0xFFFFFFFF); // Text on secondary
  static const secondaryContainer = Color(0xFFD7E3F7); // Secondary container
  static const onSecondaryContainer =
      Color(0xFF101C2B); // Text on secondary container

  static const tertiary = Color(0xFF6B5778); // Tertiary color
  static const onTertiary = Color(0xFFFFFFFF); // Text on tertiary
  static const tertiaryContainer = Color(0xFFF2DAFF); // Tertiary container
  static const onTertiaryContainer =
      Color(0xFF251431); // Text on tertiary container

  static const background = Color(0xFFF8F9FF); // Background
  static const onBackground = Color(0xFF191C20); // Text on background
  static const surface = Color(0xFFF8F9FF); // Surface
  static const onSurface = Color(0xFF191C20); // Text on surface
  static const surfaceVariant = Color(0xFFDFE2EB); // Surface variant
  static const onSurfaceVariant = Color(0xFF43474E); // Text on surface variant

  static const error = Color(0xFFBA1A1A); // Error color
  static const onError = Color(0xFFFFFFFF); // Text on error
  static const errorContainer = Color(0xFFFFDAD6); // Error container
  static const onErrorContainer = Color(0xFF410002); // Text on error container

  static const outline = Color(0xFF73777F); // Outline color
  static const outlineVariant = Color(0xFFC3C7CF); // Outline variant

  /// TYPOGRAPHY REFERENCE
  /// --------------------------------------------------
  static const typographyGuide = '''
  Display Styles
  displayLarge    -> 57px, weight: 400, spacing: -0.25
  displayMedium   -> 45px, weight: 400, spacing: 0
  displaySmall    -> 36px, weight: 400, spacing: 0

  Headline Styles
  headlineLarge   -> 32px, weight: 400, spacing: 0
  headlineMedium  -> 28px, weight: 400, spacing: 0
  headlineSmall   -> 24px, weight: 400, spacing: 0

  Title Styles
  titleLarge      -> 22px, weight: 400, spacing: 0
  titleMedium     -> 16px, weight: 500, spacing: 0.15
  titleSmall      -> 14px, weight: 500, spacing: 0.1

  Label Styles
  labelLarge      -> 14px, weight: 500, spacing: 0.1
  labelMedium     -> 12px, weight: 500, spacing: 0.5
  labelSmall      -> 11px, weight: 500, spacing: 0.5

  Body Styles
  bodyLarge       -> 16px, weight: 400, spacing: 0.5
  bodyMedium      -> 14px, weight: 400, spacing: 0.25
  bodySmall       -> 12px, weight: 400, spacing: 0.4
  ''';

  /// COMPONENT THEMES
  /// --------------------------------------------------
  static const componentGuide = '''
  ElevatedButton {
    backgroundColor: primary
    foregroundColor: onPrimary
    minimumSize: Size(88, 36)
    padding: EdgeInsets.symmetric(horizontal: 16)
    shape: RoundedRectangleBorder(borderRadius: 8)
  }

  TextField {
    filled: true
    fillColor: surfaceVariant
    border: OutlineInputBorder(
      borderRadius: 8
      borderSide: none
    )
  }

  Card {
    color: surface
    elevation: 0
    shape: RoundedRectangleBorder(borderRadius: 12)
  }

  AppBar {
    backgroundColor: surface
    foregroundColor: onSurface
    elevation: 0
  }
  ''';

  /// USAGE EXAMPLES
  /// --------------------------------------------------
  static const usageGuide = '''
  color: Theme.of(context).colorScheme.primary
  backgroundColor: Theme.of(context).colorScheme.surface

  style: Theme.of(context).textTheme.titleLarge
  style: Theme.of(context).textTheme.bodyMedium

  extension ThemeX on BuildContext {
    ThemeData get theme => Theme.of(this);
    ColorScheme get colors => theme.colorScheme;
    TextTheme get text => theme.textTheme;
  }
  ''';
}
