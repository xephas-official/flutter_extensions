import '../../app_exporter.dart';

/// Application theme configuration with blue color scheme
class AppTheme {
  /// Light theme with blue primary color
  static ThemeData get lightTheme {
    // Get base text theme
    final textTheme = ThemeData.light().textTheme;

    // Text style function using Raleway
    const textStyleFunction = GoogleFonts.raleway;

    const colorScheme = ColorScheme.light(
      primary: blue,
      primaryContainer: Color(0xFFD8E6FF),
      onPrimaryContainer: navyBlue,
      secondary: Color(0xFF535F71),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD7E3F8),
      onSecondaryContainer: Color(0xFF101C2B),
      tertiary: Color(0xFF6B5778),
      onTertiary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1A1A),
      surface: Color(0xFFFFFBFE),
      onSurface: Color(0xFF1A1C1E),
      surfaceContainerHighest: Color(0xFFE1E2E5),
      onSurfaceVariant: Color(0xFF44474E),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFFFFBFE),

      //* -- Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      //* -- Appbar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: blue,
        foregroundColor: white,
        titleTextStyle: boldTextStyle.copyWith(
          fontSize: 18,
          color: white,
        ),
      ),

      //* -- Tooltip
      tooltipTheme: TooltipThemeData(
        textStyle: regularTextStyle.copyWith(
          color: const Color(0xFF1A1C1E),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFD8E6FF),
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      //* -- Text Button
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
        ),
      ),

      //* -- Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      //* -- Filled Button
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      //* -- Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      //* -- Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
      ),

      //* -- Text Theme
      textTheme: TextTheme(
        displayLarge: textStyleFunction(textStyle: textTheme.displayLarge),
        displayMedium: textStyleFunction(textStyle: textTheme.displayMedium),
        displaySmall: textStyleFunction(textStyle: textTheme.displaySmall),
        headlineLarge: textStyleFunction(textStyle: textTheme.headlineLarge),
        headlineMedium: textStyleFunction(textStyle: textTheme.headlineMedium),
        headlineSmall: textStyleFunction(textStyle: textTheme.headlineSmall),
        titleLarge: textStyleFunction(textStyle: textTheme.titleLarge),
        titleMedium: textStyleFunction(textStyle: textTheme.titleMedium),
        titleSmall: textStyleFunction(textStyle: textTheme.titleSmall),
        bodyLarge: textStyleFunction(textStyle: textTheme.bodyLarge),
        bodyMedium: textStyleFunction(textStyle: textTheme.bodyMedium),
        bodySmall: textStyleFunction(textStyle: textTheme.bodySmall),
        labelLarge: textStyleFunction(textStyle: textTheme.labelLarge),
        labelMedium: textStyleFunction(textStyle: textTheme.labelMedium),
        labelSmall: textStyleFunction(textStyle: textTheme.labelSmall),
      ),
    );
  }
}
