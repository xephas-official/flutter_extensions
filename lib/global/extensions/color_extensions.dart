import '../../app_exporter.dart';

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
}

/// MaterialColor extension
extension MaterialColorExtensions on MaterialColor {
  /// Gets the shade or returns the primary color
  Color shadeOrPrimary(int shade) {
    return this[shade] ?? this;
  }
}
