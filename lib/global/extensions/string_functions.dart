import '../utils/text_label.dart';

/// String utility functions (traditional approach without extensions).
///
/// This file demonstrates the traditional function-based approach for string
/// manipulation. Compare this with `string_extensions.dart` to see how
/// extensions provide a cleaner, more readable API.
///
/// Key disadvantages of this approach:
/// - Every function call requires passing the string as a parameter
/// - No method chaining - must use nested calls or intermediate variables
/// - Less discoverable - IDE autocomplete doesn't suggest these functions
/// - More verbose and repetitive code
/// - Breaks the natural flow of reading code left-to-right

/// Converts a string to camelCase.
///
/// Example:
/// ```dart
/// toCamelCase('hello world')  // 'helloWorld'
/// toCamelCase('hello_world')  // 'helloWorld'
/// ```
String toCamelCase(String input) {
  final words = _splitIntoWords(input);
  if (words.isEmpty) return input;

  return words.first.toLowerCase() + words.skip(1).map(_capitalize).join();
}

/// is droidcon ug
bool isDroidconUG(String input) {
  return input.toLowerCase() == 'droidconug';
}


/// Converts a string to CONSTANT_CASE (uppercase with underscores).
///
/// Example:
/// ```dart
/// toConstantCase('helloWorld')  // 'HELLO_WORLD'
/// ```
String toConstantCase(String input) {
  return _splitIntoWords(input).join('_').toUpperCase();
}

/// Converts a string to dot.case (lowercase with dots).
///
/// Example:
/// ```dart
/// toDotCase('helloWorld')  // 'hello.world'
/// ```
String toDotCase(String input) {
  return _splitIntoWords(input).map((w) => w.toLowerCase()).join('.');
}

/// Converts a string to Header-Case (capitalized words with hyphens).
///
/// Example:
/// ```dart
/// toHeaderCase('helloWorld')  // 'Hello-World'
/// ```
String toHeaderCase(String input) {
  return _splitIntoWords(input).map(_capitalize).join('-');
}

/// Converts a string to lowercase with spaces.
///
/// Example:
/// ```dart
/// toLowerCaseWithSpaces('HelloWorld')  // 'hello world'
/// ```
String toLowerCaseWithSpaces(String input) {
  return _splitIntoWords(input).map((w) => w.toLowerCase()).join(' ');
}

/// Converts a string to PascalCase.
///
/// Example:
/// ```dart
/// toPascalCase('helloWorld')  // 'HelloWorld'
/// ```
String toPascalCase(String input) {
  return _splitIntoWords(input).map(_capitalize).join();
}

/// Converts a string to param-case (lowercase with hyphens).
///
/// Example:
/// ```dart
/// toParamCase('helloWorld')  // 'hello-world'
/// ```
String toParamCase(String input) {
  return _splitIntoWords(input).map((w) => w.toLowerCase()).join('-');
}

/// Converts a string to path/case (lowercase with slashes).
///
/// Example:
/// ```dart
/// toPathCase('helloWorld')  // 'hello/world'
/// ```
String toPathCase(String input) {
  return _splitIntoWords(input).map((w) => w.toLowerCase()).join('/');
}

/// Converts a string to Sentence case.
///
/// Example:
/// ```dart
/// toSentenceCase('helloWorld')  // 'Hello world'
/// ```
String toSentenceCase(String input) {
  final words = _splitIntoWords(input).map((w) => w.toLowerCase()).toList();
  if (words.isEmpty) return input;

  words[0] = _capitalize(words[0]);
  return words.join(' ');
}

/// Converts a string to snake_case (lowercase with underscores).
///
/// Example:
/// ```dart
/// toSnakeCase('helloWorld')  // 'hello_world'
/// ```
String toSnakeCase(String input) {
  return _splitIntoWords(input).map((w) => w.toLowerCase()).join('_');
}

/// Converts a string to Title Case.
///
/// Example:
/// ```dart
/// toTitleCase('helloWorld')  // 'Hello World'
/// ```
String toTitleCase(String input) {
  return _splitIntoWords(input).map(_capitalize).join(' ');
}

/// Converts a string to UPPERCASE with spaces.
///
/// Example:
/// ```dart
/// toUpperCaseWithSpaces('helloWorld')  // 'HELLO WORLD'
/// ```
String toUpperCaseWithSpaces(String input) {
  return _splitIntoWords(input).map((w) => w.toUpperCase()).join(' ');
}

/// Wraps a string with quotes.
///
/// Example:
/// ```dart
/// addQuotes('hello')  // '"hello"'
/// ```
String addQuotes(String input) {
  return '"$input"';
}

/// Returns the initials of the string.
///
/// Example:
/// ```dart
/// getInitials('hello world')  // 'HW'
/// ```
String getInitials(String input) {
  final words = _splitIntoWords(input);
  if (words.isEmpty) return '';

  return words.map((w) => w[0].toUpperCase()).join();
}

/// Splits a string by space into a list.
///
/// Example:
/// ```dart
/// splitToList('hello world')  // ['hello', 'world']
/// ```
List<String> splitToList(String input) {
  return input.split(' ');
}

/// Capitalizes the first letter of the string.
///
/// Example:
/// ```dart
/// capitalize('hello')  // 'Hello'
/// ```
String capitalize(String input) {
  if (input.isEmpty) return input;
  return '${input[0].toUpperCase()}${input.substring(1)}';
}

/// Decapitalizes the first letter of the string.
///
/// Example:
/// ```dart
/// decapitalize('Hello')  // 'hello'
/// ```
String decapitalize(String input) {
  if (input.isEmpty) return input;
  return '${input[0].toLowerCase()}${input.substring(1)}';
}

/// Returns true if the string is a valid email address.
///
/// Example:
/// ```dart
/// isValidEmail('test@example.com')  // true
/// ```
bool isValidEmail(String input) {
  return RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(input);
}

/// Returns true if string is empty or consists solely of whitespace.
///
/// Example:
/// ```dart
/// isBlank('   ')  // true
/// ```
bool isBlank(String input) {
  return input.trim().isEmpty;
}

/// Returns true if string contains characters other than whitespace.
///
/// Example:
/// ```dart
/// isNotBlank('hello')  // true
/// ```
bool isNotBlank(String input) {
  return !isBlank(input);
}

/// Returns the string in reverse order.
///
/// Example:
/// ```dart
/// reverseString('hello')  // 'olleh'
/// ```
String reverseString(String input) {
  return input.split('').reversed.join();
}

/// Removes a prefix from the string if it exists.
///
/// Example:
/// ```dart
/// removePrefix('HelloWorld', 'Hello')  // 'World'
/// ```
String removePrefix(String input, String prefix) {
  if (input.startsWith(prefix)) {
    return input.substring(prefix.length);
  }
  return input;
}

/// Removes a suffix from the string if it exists.
///
/// Example:
/// ```dart
/// removeSuffix('filename.dart', '.dart')  // 'filename'
/// ```
String removeSuffix(String input, String suffix) {
  if (input.endsWith(suffix)) {
    return input.substring(0, input.length - suffix.length);
  }
  return input;
}

/// Parses the string as an integer, returning null if parsing fails.
///
/// Example:
/// ```dart
/// parseIntOrNull('42')  // 42
/// ```
int? parseIntOrNull(String input) {
  return int.tryParse(input);
}

/// Parses the string as a double, returning null if parsing fails.
///
/// Example:
/// ```dart
/// parseDoubleOrNull('3.14')  // 3.14
/// ```
double? parseDoubleOrNull(String input) {
  return double.tryParse(input);
}

/// Adds thousand separators to a numeric string.
///
/// Example:
/// ```dart
/// addThousandSeparators('1234567')  // '1,234,567'
/// ```
String addThousandSeparators(String input) {
  return input.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match match) => '${match[1]},',
  );
}

/// Converts string to a TextLabel for the given case type.
///
/// Example:
/// ```dart
/// stringAsTextLabel('hello world', 'camelCase')
/// // TextLabel(label: 'camelCase', value: 'helloWorld')
/// ```
TextLabel stringAsTextLabel(String input, String caseType) {
  String convertedValue;
  switch (caseType) {
    case 'camelCase':
      convertedValue = toCamelCase(input);
    case 'snake_case':
      convertedValue = toSnakeCase(input);
    case 'PascalCase':
      convertedValue = toPascalCase(input);
    case 'kebab-case':
      convertedValue = toParamCase(input);
    case 'CONSTANT_CASE':
      convertedValue = toConstantCase(input);
    case 'dot.case':
      convertedValue = toDotCase(input);
    case 'path/case':
      convertedValue = toPathCase(input);
    case 'Title Case':
      convertedValue = toTitleCase(input);
    case 'Sentence case':
      convertedValue = toSentenceCase(input);
    case 'UPPER CASE':
      convertedValue = toUpperCaseWithSpaces(input);
    case 'lower case':
      convertedValue = toLowerCaseWithSpaces(input);
    case 'with quotes':
      convertedValue = addQuotes(input);
    case 'initials':
      convertedValue = getInitials(input);
    case 'as list':
      convertedValue = splitToList(input).toString();
    default:
      convertedValue = input;
  }
  return TextLabel(
    label: caseType,
    value: convertedValue,
  );
}

/// Returns a list of TextLabels for all case conversions.
///
/// Example:
/// ```dart
/// stringToTextLabels('hello world')
/// // Returns list of all case conversion TextLabels
/// ```
List<TextLabel> stringToTextLabels(String input) {
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

  return cases.map((caseType) => stringAsTextLabel(input, caseType)).toList();
}

// Helper functions (private)

/// Capitalizes the first letter of a string.
String _capitalize(String input) {
  if (input.isEmpty) return input;
  return '${input[0].toUpperCase()}${input.substring(1)}';
}

/// Splits the string into words for case conversion.
List<String> _splitIntoWords(String input) {
  if (input.isEmpty) return [];

  // Handle camelCase and PascalCase
  var processed = input.replaceAllMapped(
    RegExp('([a-z])([A-Z])'),
    (match) => '${match[1]} ${match[2]}',
  );

  // Handle consecutive capitals
  processed = processed.replaceAllMapped(
    RegExp('([A-Z]+)([A-Z][a-z])'),
    (match) => '${match[1]!.substring(0, match[1]!.length - 1)} ${match[2]}',
  );

  // Replace separators with spaces
  processed = processed.replaceAll(RegExp(r'[_\-./]'), ' ');

  // Remove mustache braces
  processed = processed.replaceAll(RegExp('[{}]'), '');

  // Split and filter
  return processed
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
}
