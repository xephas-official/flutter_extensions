import '../utils/text_label.dart';

/// String extensions for case conversions, validation, and text manipulation.
///
/// Provides comprehensive case conversion utilities (camelCase, snake_case, etc.)
/// inspired by dartx package and common Flutter/Dart patterns.
extension StringExtensions on String {
  /// Converts a string to camelCase.
  ///
  /// Splits on spaces, underscores, hyphens, and dots, then joins with
  /// lowercase first word and capitalized subsequent words.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.inCamelCase  // 'helloWorld'
  /// 'hello_world'.inCamelCase  // 'helloWorld'
  /// 'Hello-World'.inCamelCase  // 'helloWorld'
  /// ```
  String get inCamelCase {
    final words = _splitIntoWords();
    if (words.isEmpty) return this;

    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join();
  }

  /// is "FlutterconKE"
  /// checks if a string is flutterconke
  bool get isFlutterconKE {
    return toLowerCase() == 'flutterconke';
  }

  // is droid con
  /// checks if a string is droidcon ug
  bool get isDroidconUG {
    return toLowerCase() == 'droidconug';
  }

  /// Converts a string to CONSTANT_CASE (uppercase with underscores).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inConstantCase  // 'HELLO_WORLD'
  /// 'hello world'.inConstantCase  // 'HELLO_WORLD'
  /// ```
  String get inConstantCase {
    return _splitIntoWords().join('_').toUpperCase();
  }

  /// Converts a string to dot.case (lowercase with dots).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inDotCase  // 'hello.world'
  /// 'hello_world'.inDotCase  // 'hello.world'
  /// ```
  String get inDotCase {
    return _splitIntoWords().map((w) => w.toLowerCase()).join('.');
  }

  /// Converts a string to Header-Case (capitalized words with hyphens).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inHeaderCase  // 'Hello-World'
  /// 'hello world'.inHeaderCase  // 'Hello-World'
  /// ```
  String get inHeaderCase {
    return _splitIntoWords().map((w) => w.capitalize).join('-');
  }

  /// Converts a string to lowercase with spaces.
  ///
  /// Example:
  /// ```dart
  /// 'HelloWorld'.inLowerCase  // 'hello world'
  /// 'hello_world'.inLowerCase  // 'hello world'
  /// ```
  String get inLowerCase {
    return _splitIntoWords().map((w) => w.toLowerCase()).join(' ');
  }

  /// Converts a string to PascalCase.
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inPascalCase  // 'HelloWorld'
  /// 'hello_world'.inPascalCase  // 'HelloWorld'
  /// ```
  String get inPascalCase {
    return _splitIntoWords().map((w) => w.capitalize).join();
  }

  /// Converts a string to param-case (lowercase with hyphens).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inParamCase  // 'hello-world'
  /// 'hello_world'.inParamCase  // 'hello-world'
  /// ```
  String get inParamCase {
    return _splitIntoWords().map((w) => w.toLowerCase()).join('-');
  }

  /// Converts a string to path/case (lowercase with slashes).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inPathCase  // 'hello/world'
  /// 'hello_world'.inPathCase  // 'hello/world'
  /// ```
  String get inPathCase {
    return _splitIntoWords().map((w) => w.toLowerCase()).join('/');
  }

  /// Converts a string to Sentence case.
  ///
  /// First word capitalized, rest lowercase, separated by spaces.
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inSentenceCase  // 'Hello world'
  /// 'HELLO_WORLD'.inSentenceCase  // 'Hello world'
  /// ```
  String get inSentenceCase {
    final words = _splitIntoWords().map((w) => w.toLowerCase()).toList();
    if (words.isEmpty) return this;

    words[0] = words[0].capitalize;
    return words.join(' ');
  }

  /// Converts a string to snake_case (lowercase with underscores).
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inSnakeCase  // 'hello_world'
  /// 'Hello World'.inSnakeCase  // 'hello_world'
  /// ```
  String get inSnakeCase {
    return _splitIntoWords().map((w) => w.toLowerCase()).join('_');
  }

  /// Converts a string to Title Case.
  ///
  /// All words capitalized, separated by spaces.
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inTitleCase  // 'Hello World'
  /// 'hello_world'.inTitleCase  // 'Hello World'
  /// ```
  String get inTitleCase {
    return _splitIntoWords().map((w) => w.capitalize).join(' ');
  }

  /// Converts a string to UPPERCASE with spaces.
  ///
  /// Example:
  /// ```dart
  /// 'helloWorld'.inUpperCase  // 'HELLO WORLD'
  /// 'hello_world'.inUpperCase  // 'HELLO WORLD'
  /// ```
  String get inUpperCase {
    return _splitIntoWords().map((w) => w.toUpperCase()).join(' ');
  }

  /// with quotes
  String get withQuotes {
    return '"$this"';
  }

  /// as initials
  /// Returns the initials of the string.
  String get asInitials {
    final words = _splitIntoWords();
    if (words.isEmpty) return '';

    return words.map((w) => w[0].toUpperCase()).join();
  }

  /// splits a string by space
  List<String> get asList => split(' ');

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

  /// Splits the string into words for case conversion.
  ///
  /// Handles camelCase, PascalCase, snake_case, param-case, dot.case,
  /// path/case, and space-separated words.
  List<String> _splitIntoWords() {
    if (isEmpty) return [];

    // First, handle camelCase and PascalCase by adding spaces before capitals
    var processed = replaceAllMapped(
      RegExp('([a-z])([A-Z])'),
      (match) => '${match[1]} ${match[2]}',
    );

    // Also handle consecutive capitals followed by lowercase (e.g., "XMLParser" -> "XML Parser")
    processed = processed.replaceAllMapped(
      RegExp('([A-Z]+)([A-Z][a-z])'),
      (match) => '${match[1]!.substring(0, match[1]!.length - 1)} ${match[2]}',
    );

    // Replace separators (_, -, ., /) with spaces
    processed = processed.replaceAll(RegExp(r'[_\-./]'), ' ');

    // Remove mustache braces if present
    processed = processed.replaceAll(RegExp('[{}]'), '');

    // Split on whitespace and filter out empty strings
    return processed
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
  }

  /// as TextLabel
  /// Example is that if we're changing a string to a given case, that case becomes the label and the value is the converted string
  /// TextLabel asTextLabel(String caseType) {
  ///   switch (caseType) {
  ///     case 'camelCase':
  ///       return TextLabel(
  ///         label: caseType,
  ///         value: this.camelCase,
  ///       );
  ///     case 'snake_case':
  ///       return TextLabel(
  ///         label: caseType,
  ///         value: this.snakeCase,
  ///       );
  ///     // Add more cases as needed
  ///     default:
  ///       return TextLabel(
  ///         label: caseType,
  ///         value: this,
  ///       );
  ///   }
  /// }
  TextLabel asTextLabel(String caseType) {
    String convertedValue;
    switch (caseType) {
      case 'camelCase':
        convertedValue = inCamelCase;
      case 'snake_case':
        convertedValue = inSnakeCase;
      case 'PascalCase':
        convertedValue = inPascalCase;
      case 'kebab-case':
        convertedValue = inParamCase;
      case 'CONSTANT_CASE':
        convertedValue = inConstantCase;
      case 'dot.case':
        convertedValue = inDotCase;
      case 'path/case':
        convertedValue = inPathCase;
      case 'Title Case':
        convertedValue = inTitleCase;
      case 'Sentence case':
        convertedValue = inSentenceCase;
      case 'UPPER CASE':
        convertedValue = inUpperCase;
      case 'lower case':
        convertedValue = inLowerCase;
      case 'with quotes':
        convertedValue = withQuotes;
      case 'initials':
        convertedValue = asInitials;
      case 'as list':
        convertedValue = asList.toString();
      default:
        convertedValue = this;
    }
    return TextLabel(
      label: caseType,
      value: convertedValue,
    );
  }

  /// add a getter called to textLabels that returns a list of TextLabel for all cases
  List<TextLabel> get toTextLabels {
    final cases = [
      'camelCase',
      'snake_case',
      'PascalCase',
      'kebab-case',
      'CONSTANT_CASE',
      'dot.case',
      'path/case',
      'Title Case',
      'Sentence case',
      'UPPER CASE',
      'lower case',
      'with quotes',
      'initials',
      'as list',
    ];

    return cases.map(asTextLabel).toList();
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
