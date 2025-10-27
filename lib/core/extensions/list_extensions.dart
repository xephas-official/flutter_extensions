import 'package:flutter/material.dart';

/// List extensions for common operations
extension ListExtensions<T> on List<T> {
  /// Returns true if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Returns true if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Returns first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Divides list items with a separator
  List<T> divide(T separator) {
    if (isEmpty) return this;
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(separator);
    }
    return result;
  }
}

/// `List<Widget>` specific extensions
extension WidgetListExtensions on List<Widget> {
  /// Adds spacing between widgets in a Column
  Column toColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacing > 0 ? divide(SizedBox(height: spacing)) : this,
    );
  }

  /// Adds spacing between widgets in a Row
  Row toRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacing > 0 ? divide(SizedBox(width: spacing)) : this,
    );
  }

  /// Wraps widgets in a ListView
  ListView toListView({
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
  }) {
    return ListView(
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      children: this,
    );
  }

  /// Wraps widgets in a Wrap
  Wrap toWrap({
    double spacing = 0,
    double runSpacing = 0,
    WrapAlignment alignment = WrapAlignment.start,
  }) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: this,
    );
  }
}
