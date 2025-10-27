import 'package:flutter/material.dart';

/// BuildContext extensions for easier access to common properties
extension ContextExtensions on BuildContext {
  /// Returns the current ThemeData
  ThemeData get theme => Theme.of(this);

  /// Returns the current ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the current TextTheme
  TextTheme get textTheme => theme.textTheme;

  /// Returns the MediaQuery size
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns the screen width
  double get screenWidth => screenSize.width;

  /// Returns the screen height
  double get screenHeight => screenSize.height;

  /// Returns the MediaQueryData
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns true if device is in landscape mode
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Returns true if device is in portrait mode
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Shows a SnackBar with the given message
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  /// Shows a Material banner
  void showBanner(String message) {
    ScaffoldMessenger.of(this).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(this).hideCurrentMaterialBanner(),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  /// Pops the current route
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Pushes a new route
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }
}
