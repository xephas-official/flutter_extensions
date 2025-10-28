/// String extensions for converting between camelCase and snake_case,
/// validation, and text manipulation.
///
/// Inspired by dartx package and common Flutter/Dart patterns.
extension StringExtensions on String {
  /// Converts a string from camelCase to snake_case.
  ///
  /// Example:
  /// ```dart
  /// 'userId'.inSnakeCase  // 'user_id'
  /// 'myVariableName'.inSnakeCase  // 'my_variable_name'
  /// ```
  String get inSnakeCase {
    return replaceAllMapped(
      RegExp('([a-z])([A-Z])'),
      (Match match) => '${match.group(1)}_${match.group(2)?.toLowerCase()}',
    );
  }

  /// Converts a string from snake_case to camelCase.
  ///
  /// Example:
  /// ```dart
  /// 'user_id'.inCamelCase  // 'userId'
  /// 'my_variable_name'.inCamelCase  // 'myVariableName'
  /// ```
  String get inCamelCase {
    return replaceAllMapped(
      RegExp('_([a-z])'),
      (Match match) => match.group(1)!.toUpperCase(),
    );
  }

  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.capitalize  // 'Hello'
  /// 'WORLD'.capitalize  // 'WORLD'
  /// ```
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Decapitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// 'Hello'.decapitalize  // 'hello'
  /// 'WORLD'.decapitalize  // 'wORLD'
  /// ```
  String get decapitalize {
    if (isEmpty) return this;
    return '${this[0].toLowerCase()}${substring(1)}';
  }

  /// Returns true if the string is a valid email address.
  ///
  /// Uses a simple regex pattern for common email validation.
  ///
  /// Example:
  /// ```dart
  /// 'test@example.com'.isValidEmail  // true
  /// 'invalid-email'.isValidEmail     // false
  /// ```
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// Returns true if this string is empty or consists solely of whitespace.
  ///
  /// Example:
  /// ```dart
  /// ''.isBlank       // true
  /// '   '.isBlank    // true
  /// ' a '.isBlank    // false
  /// ```
  bool get isBlank => trim().isEmpty;

  /// Returns true if this string contains characters other than whitespace.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.isNotBlank   // true
  /// '   '.isNotBlank     // false
  /// ```
  bool get isNotBlank => !isBlank;

  /// Returns the string in reverse order.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.reversed  // 'olleh'
  /// 'Dart'.reversed   // 'traD'
  /// ```
  String get reversed => split('').reversed.join();

  /// Removes a prefix from the string if it exists.
  ///
  /// Example:
  /// ```dart
  /// 'HelloWorld'.removePrefix('Hello')  // 'World'
  /// 'Dart'.removePrefix('Go')           // 'Dart'
  /// ```
  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      return substring(prefix.length);
    }
    return this;
  }

  /// Removes a suffix from the string if it exists.
  ///
  /// Example:
  /// ```dart
  /// 'filename.dart'.removeSuffix('.dart')  // 'filename'
  /// '100ms'.removeSuffix('ms')             // '100'
  /// ```
  String removeSuffix(String suffix) {
    if (endsWith(suffix)) {
      return substring(0, length - suffix.length);
    }
    return this;
  }

  /// Parses the string as an integer, returning null if parsing fails.
  ///
  /// More null-safe than int.parse() which throws.
  ///
  /// Example:
  /// ```dart
  /// '42'.toIntOrNull()     // 42
  /// 'not a number'.toIntOrNull()  // null
  /// ```
  int? toIntOrNull() => int.tryParse(this);

  /// Parses the string as a double, returning null if parsing fails.
  ///
  /// More null-safe than double.parse() which throws.
  ///
  /// Example:
  /// ```dart
  /// '3.14'.toDoubleOrNull()  // 3.14
  /// 'abc'.toDoubleOrNull()   // null
  /// ```
  double? toDoubleOrNull() => double.tryParse(this);

  /// Adds thousand separators to a numeric string.
  ///
  /// Useful for displaying large numbers in a readable format.
  ///
  /// Example:
  /// ```dart
  /// '1234567'.withThousandSeparators  // '1,234,567'
  /// '999'.withThousandSeparators      // '999'
  /// ```
  String get withThousandSeparators {
    return replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }
}

/// Extension for nullable strings.
extension NullableStringExtensions on String? {
  /// Returns the string if it is not null, or an empty string otherwise.
  ///
  /// Useful for handling nullable strings safely.
  ///
  /// Example:
  /// ```dart
  /// String? nullableString;
  /// nullableString.orEmpty  // ''
  ///
  /// String? someString = 'Hello';
  /// someString.orEmpty  // 'Hello'
  /// ```
  String get orEmpty => this ?? '';

  /// Returns true if the string is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? str;
  /// str.isNullOrEmpty  // true
  /// str = '';
  /// str.isNullOrEmpty  // true
  /// str = 'text';
  /// str.isNullOrEmpty  // false
  /// ```
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the string is null or blank (empty/whitespace only).
  ///
  /// Example:
  /// ```dart
  /// String? str;
  /// str.isNullOrBlank  // true
  /// str = '   ';
  /// str.isNullOrBlank  // true
  /// ```
  bool get isNullOrBlank => this == null || this!.isBlank;
}
