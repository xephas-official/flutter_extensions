import '../../app_exporter.dart';

/// chip that shows a given value
class ValueChip extends StatelessWidget {
  /// constructor
  const ValueChip({
    required this.backColor,
    required this.valueText,
    required this.fadeBack,
    required this.textColor,
    this.borderRadius = borderRadius200,
    this.fontSize = 8.5,
    super.key,
  });

  /// background color
  final Color backColor;

  ///text color
  final Color textColor;

  /// border radius
  final BorderRadiusGeometry? borderRadius;

  /// value text
  final String valueText;

  /// fade back
  final bool fadeBack;

  /// font size
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize > 10 ? spacing16 : spacing8,
        vertical: spacing4,
      ),
      decoration: BoxDecoration(
        color: fadeBack ? backColor.withValues(alpha: .2) : backColor,
        borderRadius: borderRadius,
      ),
      child: Text(
        valueText.capitalize,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: boldTextStyle.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
