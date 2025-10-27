import 'package:flutter/material.dart';

/// Widget extensions for common modifications
extension WidgetExtensions on Widget {
  /// Adds padding to the widget
  Widget padding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  /// Adds symmetric padding to the widget
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Adds padding to all sides
  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// Adds only-side padding
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Centers the widget
  Widget get center => Center(child: this);

  /// Expands the widget
  Widget get expanded => Expanded(child: this);

  /// Makes widget flexible
  Widget flexible({int flex = 1}) => Flexible(flex: flex, child: this);

  /// Wraps widget with Card
  Widget card({
    double? elevation,
    Color? color,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
  }) {
    return Card(
      elevation: elevation,
      color: color,
      shape: shape,
      margin: margin,
      child: this,
    );
  }

  /// Wraps widget with Container
  Widget container({
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: this,
    );
  }

  /// Makes widget tappable
  Widget onTap(VoidCallback onTap, {BorderRadius? borderRadius}) {
    return InkWell(onTap: onTap, borderRadius: borderRadius, child: this);
  }

  /// Wraps widget with Hero
  Widget hero(String tag) {
    return Hero(tag: tag, child: this);
  }

  /// Makes widget visible conditionally
  Widget visible(bool isVisible) {
    return Visibility(visible: isVisible, child: this);
  }

  /// Shows widget or replacement based on condition
  Widget showIf(bool condition, {Widget? fallback}) {
    return condition ? this : (fallback ?? const SizedBox.shrink());
  }
}
