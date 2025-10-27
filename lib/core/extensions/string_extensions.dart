/// String extensions for converting between camelCase and snake_case
extension StringExtensions on String {
  /// Converts a string from camelCase to snake_case
  /// Example: 'userId' -> 'user_id'
  String get inSnakeCase {
    return replaceAllMapped(
      RegExp('([a-z])([A-Z])'),
      (Match match) => '${match.group(1)}_${match.group(2)?.toLowerCase()}',
    );
  }

  /// Converts a string from snake_case to camelCase
  /// Example: 'user_id' -> 'userId'
  String get inCamelCase {
    return replaceAllMapped(
      RegExp('_([a-z])'),
      (Match match) => match.group(1)!.toUpperCase(),
    );
  }

  /// Capitalizes the first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns true if string is a valid email
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }
}
