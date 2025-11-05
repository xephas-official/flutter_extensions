import '../utils/text_label.dart';

/// Boolean extensions for common operations.
///
/// Provides utility methods for working with boolean values including
/// toggle functionality and TextLabel conversion for demonstration.
extension BoolExtensions on bool {
  /// Toggles the boolean value.
  ///
  /// Returns the opposite of the current boolean value.
  ///
  /// Example:
  /// ```dart
  /// bool isExpanded = false;
  /// isExpanded = isExpanded.toggle;  // true
  /// isExpanded = isExpanded.toggle;  // false
  /// ```
  bool get toggle => !this;

  /// Converts to 'Yes' or 'No' string.
  ///
  /// Returns 'Yes' if true, 'No' if false.
  String get toYesNo => this ? 'Yes' : 'No';

  /// Converts to 'ON' or 'OFF' string.
  ///
  /// Returns 'ON' if true, 'OFF' if false.
  String get toOnOff => this ? 'ON' : 'OFF';

  /// Converts to 'Enabled' or 'Disabled' string.
  ///
  /// Returns 'Enabled' if true, 'Disabled' if false.
  String get toEnabledDisabled => this ? 'Enabled' : 'Disabled';

  /// Converts to 'Active' or 'Inactive' string.
  ///
  /// Returns 'Active' if true, 'Inactive' if false.
  String get toActiveInactive => this ? 'Active' : 'Inactive';

  /// Converts to '✓' or '✗' string.
  ///
  /// Returns checkmark if true, X mark if false.
  String get toCheckmark => this ? '✓' : '✗';

  /// Converts to integer (1 or 0).
  ///
  /// Returns 1 if true, 0 if false.
  int get toInt => this ? 1 : 0;

  // ============ TextLabel Conversion ============

  /// Converts a boolean to a TextLabel with a specific format.
  ///
  /// Returns TextLabel with the format type as label and formatted value.
  TextLabel asTextLabel(String formatType) {
    String convertedValue;
    switch (formatType) {
      case 'Value':
        convertedValue = toString();
      case 'Yes/No':
        convertedValue = toYesNo;
      case 'ON/OFF':
        convertedValue = toOnOff;
      case 'Enabled/Disabled':
        convertedValue = toEnabledDisabled;
      case 'Active/Inactive':
        convertedValue = toActiveInactive;
      case 'Checkmark':
        convertedValue = toCheckmark;
      case 'Integer':
        convertedValue = toInt.toString();
      case 'Toggled':
        convertedValue = toggle.toString();
      default:
        convertedValue = toString();
    }

    return TextLabel(
      label: formatType,
      value: convertedValue,
    );
  }

  /// Returns a list of TextLabels for all boolean format types.
  ///
  /// Useful for demonstrating all formatting options in UI.
  /// Each TextLabel contains the format name and the formatted value.
  List<TextLabel> get toTextLabels {
    final formats = [
      'Value',
      'Yes/No',
      'ON/OFF',
      'Enabled/Disabled',
      'Active/Inactive',
      'Checkmark',
      'Integer',
      'Toggled',
    ];

    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for text format conversions.
  ///
  /// Useful for displaying boolean in different text formats.
  List<TextLabel> get toTextFormatLabels {
    final formats = [
      'Value',
      'Yes/No',
      'ON/OFF',
      'Enabled/Disabled',
      'Active/Inactive',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for special conversions.
  ///
  /// Useful for displaying boolean as symbols or numbers.
  List<TextLabel> get toSpecialLabels {
    final formats = [
      'Checkmark',
      'Integer',
      'Toggled',
    ];
    return formats.map(asTextLabel).toList();
  }
}

/// Extension for nullable booleans.
extension NullableBoolExtensions on bool? {
  /// Returns the boolean value or false if null.
  ///
  /// Useful for handling nullable booleans safely.
  bool get orFalse => this ?? false;

  /// Returns the boolean value or true if null.
  ///
  /// Useful for handling nullable booleans safely.
  bool get orTrue => this ?? true;

  /// Returns true if the value is null.
  bool get isNull => this == null;

  /// Returns true if the value is not null.
  bool get isNotNull => this != null;
}
