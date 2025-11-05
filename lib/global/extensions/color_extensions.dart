import '../../app_exporter.dart';
import '../utils/text_label.dart';

/// Color extensions for common manipulations
extension ColorExtensions on Color {
  /// Returns a lighter shade of this color
  Color get lighter {
    return Color.alphaBlend(Colors.white.withValues(alpha: 0.3), this);
  }

  /// Returns a darker shade of this color
  Color get darker {
    return Color.alphaBlend(Colors.black.withValues(alpha: 0.3), this);
  }

  /// Returns the color with the specified opacity
  Color withOpacityValue(double opacity) {
    return withValues(alpha: opacity.clamp(0.0, 1.0));
  }

  /// Converts color to hex string
  String get toHex {
    return '#${a.toInt().toRadixString(16).padLeft(2, '0')}'
            '${r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Converts color to hex string without alpha
  String get toHexNoAlpha {
    return '#${r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Gets RGB values as a string
  String get toRGB {
    return 'RGB(${r.toInt()}, ${g.toInt()}, ${b.toInt()})';
  }

  /// Gets RGBA values as a string
  String get toRGBA {
    return 'RGBA(${r.toInt()}, ${g.toInt()}, ${b.toInt()}, ${a.toStringAsFixed(2)})';
  }

  /// Gets HSL values as a string
  String get toHSL {
    final r = this.r / 255;
    final g = this.g / 255;
    final b = this.b / 255;

    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = max - min;

    var h = 0.0;
    var s = 0.0;
    final l = (max + min) / 2;

    if (delta != 0) {
      s = l > 0.5 ? delta / (2 - max - min) : delta / (max + min);

      if (max == r) {
        h = ((g - b) / delta + (g < b ? 6 : 0)) / 6;
      } else if (max == g) {
        h = ((b - r) / delta + 2) / 6;
      } else {
        h = ((r - g) / delta + 4) / 6;
      }
    }

    return 'HSL(${(h * 360).toInt()}°, ${(s * 100).toInt()}%, ${(l * 100).toInt()}%)';
  }

  /// Gets color brightness (0.0 to 1.0)
  double get brightness {
    return (r * 0.299 + g * 0.587 + b * 0.114) / 255;
  }

  /// Checks if color is light (brightness > 0.5)
  bool get isLight => brightness > 0.5;

  /// Checks if color is dark (brightness <= 0.5)
  bool get isDark => !isLight;

  /// Returns complementary color (opposite on color wheel)
  Color get complementary {
    return Color.fromARGB(
      a.toInt(),
      255 - r.toInt(),
      255 - g.toInt(),
      255 - b.toInt(),
    );
  }

  /// Returns grayscale version of this color
  Color get grayscale {
    final gray = (r * 0.299 + g * 0.587 + b * 0.114).toInt();
    return Color.fromARGB(a.toInt(), gray, gray, gray);
  }

  /// Returns color with 10% lighter shade
  Color get lighter10 => Color.alphaBlend(
    Colors.white.withValues(alpha: 0.1),
    this,
  );

  /// Returns color with 20% lighter shade
  Color get lighter20 => Color.alphaBlend(
    Colors.white.withValues(alpha: 0.2),
    this,
  );

  /// Returns color with 30% lighter shade
  Color get lighter30 => Color.alphaBlend(
    Colors.white.withValues(alpha: 0.3),
    this,
  );

  /// Returns color with 50% lighter shade
  Color get lighter50 => Color.alphaBlend(
    Colors.white.withValues(alpha: 0.5),
    this,
  );

  /// Returns color with 10% darker shade
  Color get darker10 => Color.alphaBlend(
    Colors.black.withValues(alpha: 0.1),
    this,
  );

  /// Returns color with 20% darker shade
  Color get darker20 => Color.alphaBlend(
    Colors.black.withValues(alpha: 0.2),
    this,
  );

  /// Returns color with 30% darker shade
  Color get darker30 => Color.alphaBlend(
    Colors.black.withValues(alpha: 0.3),
    this,
  );

  /// Returns color with 50% darker shade
  Color get darker50 => Color.alphaBlend(
    Colors.black.withValues(alpha: 0.5),
    this,
  );

  /// Returns color with 10% opacity
  Color get opacity10 => withValues(alpha: 0.1);

  /// Returns color with 20% opacity
  Color get opacity20 => withValues(alpha: 0.2);

  /// Returns color with 30% opacity
  Color get opacity30 => withValues(alpha: 0.3);

  /// Returns color with 50% opacity
  Color get opacity50 => withValues(alpha: 0.5);

  /// Returns color with 70% opacity
  Color get opacity70 => withValues(alpha: 0.7);

  /// Returns color with 90% opacity
  Color get opacity90 => withValues(alpha: 0.9);

  // ============ TextLabel Conversion ============

  /// Converts a color to a TextLabel with a specific format.
  ///
  /// Returns TextLabel with the format type as label and formatted value.
  TextLabel asTextLabel(String formatType) {
    String convertedValue;
    switch (formatType) {
      case 'Hex':
        convertedValue = toHex;
      case 'Hex (No Alpha)':
        convertedValue = toHexNoAlpha;
      case 'RGB':
        convertedValue = toRGB;
      case 'RGBA':
        convertedValue = toRGBA;
      case 'HSL':
        convertedValue = toHSL;
      case 'Brightness':
        convertedValue = brightness.toStringAsFixed(2);
      case 'Is Light':
        convertedValue = isLight.toString();
      case 'Is Dark':
        convertedValue = isDark.toString();
      case 'Lighter 10%':
        convertedValue = lighter10.toHexNoAlpha;
      case 'Lighter 20%':
        convertedValue = lighter20.toHexNoAlpha;
      case 'Lighter 30%':
        convertedValue = lighter30.toHexNoAlpha;
      case 'Lighter 50%':
        convertedValue = lighter50.toHexNoAlpha;
      case 'Darker 10%':
        convertedValue = darker10.toHexNoAlpha;
      case 'Darker 20%':
        convertedValue = darker20.toHexNoAlpha;
      case 'Darker 30%':
        convertedValue = darker30.toHexNoAlpha;
      case 'Darker 50%':
        convertedValue = darker50.toHexNoAlpha;
      case 'Complementary':
        convertedValue = complementary.toHexNoAlpha;
      case 'Grayscale':
        convertedValue = grayscale.toHexNoAlpha;
      default:
        convertedValue = toHex;
    }

    return TextLabel(
      label: formatType,
      value: convertedValue,
    );
  }

  /// Returns a list of TextLabels for all color format types.
  ///
  /// Useful for demonstrating all formatting options in UI.
  /// Each TextLabel contains the format name and the formatted value.
  List<TextLabel> get toTextLabels {
    final formats = [
      'Hex',
      'Hex (No Alpha)',
      'RGB',
      'RGBA',
      'HSL',
      'Brightness',
      'Is Light',
      'Is Dark',
      'Lighter 10%',
      'Lighter 20%',
      'Lighter 30%',
      'Lighter 50%',
      'Darker 10%',
      'Darker 20%',
      'Darker 30%',
      'Darker 50%',
      'Complementary',
      'Grayscale',
    ];

    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for color format conversions.
  ///
  /// Useful for displaying color in different formats.
  List<TextLabel> get toFormatLabels {
    final formats = [
      'Hex',
      'Hex (No Alpha)',
      'RGB',
      'RGBA',
      'HSL',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for color shades.
  ///
  /// Useful for displaying lighter and darker variations.
  List<TextLabel> get toShadeLabels {
    final formats = [
      'Lighter 10%',
      'Lighter 20%',
      'Lighter 30%',
      'Lighter 50%',
      'Darker 10%',
      'Darker 20%',
      'Darker 30%',
      'Darker 50%',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for color analysis.
  ///
  /// Useful for displaying color properties.
  List<TextLabel> get toAnalysisLabels {
    final formats = [
      'Brightness',
      'Is Light',
      'Is Dark',
      'Complementary',
      'Grayscale',
    ];
    return formats.map(asTextLabel).toList();
  }
}

/// MaterialColor extension
extension MaterialColorExtensions on MaterialColor {
  /// Gets the shade or returns the primary color
  Color shadeOrPrimary(int shade) {
    return this[shade] ?? this;
  }
}
