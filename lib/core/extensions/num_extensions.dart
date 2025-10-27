import 'package:flutter/material.dart';

/// Number extensions for common operations
extension NumExtensions on num {
  /// Converts number to currency format
  /// Example: 1234.56 -> '$1,234.56'
  String get toCurrency {
    return '\$${toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}';
  }

  /// Returns SizedBox with height
  SizedBox get heightBox => SizedBox(height: toDouble());

  /// Returns SizedBox with width
  SizedBox get widthBox => SizedBox(width: toDouble());

  /// Returns EdgeInsets.all
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Returns EdgeInsets.symmetric horizontal
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Returns EdgeInsets.symmetric vertical
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Returns BorderRadius.circular
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());
}
