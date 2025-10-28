import 'package:flutter/material.dart';

import 'colors.dart';

/// Application theme configuration with blue color scheme
class AppTheme {
  /// Light theme with blue primary color
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: blue,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD8E6FF),
      onPrimaryContainer: navyBlue,
      secondary: Color(0xFF535F71),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD7E3F8),
      onSecondaryContainer: Color(0xFF101C2B),
      tertiary: Color(0xFF6B5778),
      onTertiary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFBFE),
      onSurface: Color(0xFF1A1C1E),
      surfaceContainerHighest: Color(0xFFE1E2E5),
      onSurfaceVariant: Color(0xFF44474E),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: blue,
        foregroundColor: Color(0xFFFFFFFF),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
      ),
    );
  }
}
