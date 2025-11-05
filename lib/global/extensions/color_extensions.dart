import '../../app_exporter.dart';
import '../utils/text_label.dart';

/// Color extensions for common manipulations
extension ColorExtensions on Color {
  /// Returns the color with the specified opacity
  Color withOpacityValue(double opacity) {
    return withValues(alpha: opacity.clamp(0.0, 1.0));
  }

  /// Gets the integer value of this color (0xAARRGGBB format).
  ///
  /// Returns the color as a 32-bit integer with alpha, red, green, blue channels.
  /// Example: Color(0xFF00297F).toIntValue returns 0xFF00297F (4278233471)
  int get toIntValue {
    return (a.toInt() << 24) | (r.toInt() << 16) | (g.toInt() << 8) | b.toInt();
  }

  /// Converts color to hex string with alpha (0xAARRGGBB format).
  ///
  /// Returns formatted string like '0xFF00297F'.
  String get toHexWithAlpha {
    return '0x${a.toInt().toRadixString(16).padLeft(2, '0')}'
            '${r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Converts color to hex string with alpha and hash (#AARRGGBB format).
  ///
  /// Returns formatted string like '#FF00297F'.
  String get toHex {
    return '#${a.toInt().toRadixString(16).padLeft(2, '0')}'
            '${r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Converts color to hex string without alpha (RRGGBB format).
  ///
  /// Returns 6-character hex string like '00297F' without prefix.
  String get toHexNoAlpha {
    return '${r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Converts color to hex string without alpha with hash (#RRGGBB format).
  ///
  /// Returns formatted string like '#00297F'.
  String get toHexNoAlphaWithHash {
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
  Color get opacity90 =>
      withValues(alpha: 0.9); // ============ TextLabel Conversion ============

  /// Converts a color to a TextLabel with a specific format.
  ///
  /// Returns TextLabel with the format type as label and formatted value.
  TextLabel asTextLabel(String formatType) {
    String convertedValue;
    switch (formatType) {
      case 'Integer Value':
        convertedValue = toIntValue.toString();
      case 'Hex (0x)':
        convertedValue = toHexWithAlpha;
      case 'Hex (#)':
        convertedValue = toHex;
      case 'Hex (No Alpha)':
        convertedValue = toHexNoAlpha;
      case 'Hex (# No Alpha)':
        convertedValue = toHexNoAlphaWithHash;
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
      case 'Complementary':
        convertedValue = complementary.toHexNoAlphaWithHash;
      case 'Grayscale':
        convertedValue = grayscale.toHexNoAlphaWithHash;
      case 'Opacity 10%':
        convertedValue = opacity10.toHexWithAlpha;
      case 'Opacity 30%':
        convertedValue = opacity30.toHexWithAlpha;
      case 'Opacity 50%':
        convertedValue = opacity50.toHexWithAlpha;
      case 'Opacity 70%':
        convertedValue = opacity70.toHexWithAlpha;
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
      'Integer Value',
      'Hex (0x)',
      'Hex (#)',
      'Hex (No Alpha)',
      'Hex (# No Alpha)',
      'RGB',
      'RGBA',
      'HSL',
      'Brightness',
      'Is Light',
      'Is Dark',
      'Complementary',
      'Grayscale',
      'Opacity 10%',
      'Opacity 30%',
      'Opacity 50%',
      'Opacity 70%',
    ];

    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for color format conversions.
  ///
  /// Useful for displaying color in different formats.
  List<TextLabel> get toFormatLabels {
    final formats = [
      'Integer Value',
      'Hex (0x)',
      'Hex (#)',
      'Hex (No Alpha)',
      'Hex (# No Alpha)',
      'RGB',
      'RGBA',
      'HSL',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for color opacity variations.
  ///
  /// Useful for displaying opacity variations.
  List<TextLabel> get toOpacityLabels {
    final formats = [
      'Opacity 10%',
      'Opacity 30%',
      'Opacity 50%',
      'Opacity 70%',
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

/// String extension for converting HEX strings to Color
extension HexStringToColor on String {
  /// Converts a HEX string to a Color object.
  ///
  /// Supports multiple formats:
  /// - '00297F' -> Color(0xFF00297F) - assumes full opacity
  /// - 'FF00297F' -> Color(0xFF00297F) - with alpha
  /// - '#00297F' -> Color(0xFF00297F) - with hash
  /// - '#FF00297F' -> Color(0xFF00297F) - with hash and alpha
  /// - '0xFF00297F' -> Color(0xFF00297F) - with 0x prefix
  ///
  /// Example:
  /// ```dart
  /// '00297F'.toColor       // Color(0xFF00297F)
  /// '#FF00297F'.toColor    // Color(0xFF00297F)
  /// '0xFF00297F'.toColor   // Color(0xFF00297F)
  /// ```
  Color? get toColor {
    try {
      var hexString = trim();

      // Remove hash if present
      if (hexString.startsWith('#')) {
        hexString = hexString.substring(1);
      }

      // Remove 0x prefix if present
      if (hexString.toLowerCase().startsWith('0x')) {
        hexString = hexString.substring(2);
      }

      // If only RGB (6 characters), add FF for full opacity
      if (hexString.length == 6) {
        hexString = 'FF$hexString';
      }

      // Parse as integer
      if (hexString.length == 8) {
        final intValue = int.parse(hexString, radix: 16);
        return Color(intValue);
      }

      return null;
    } on FormatException {
      return null;
    }
  }

  /// Converts a HEX string to a Color object with a fallback.
  ///
  /// Returns the parsed color or the fallback color if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// 'invalid'.toColorOr(Colors.blue)  // Colors.blue
  /// '00297F'.toColorOr(Colors.blue)   // Color(0xFF00297F)
  /// ```
  Color toColorOr(Color fallback) {
    return toColor ?? fallback;
  }
}

/// MaterialColor extension
extension MaterialColorExtensions on MaterialColor {
  /// Gets the shade or returns the primary color
  Color shadeOrPrimary(int shade) {
    return this[shade] ?? this;
  }
}
