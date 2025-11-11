// this will be a text widget as extension tile showing various extension methods

import '../../../app_exporter.dart';

/// advanced form label that also shows the hint
class ColorTitle extends StatelessWidget {
  /// constructor
  const ColorTitle({
    required this.labelColor,
    super.key,
    this.initiallyExpanded = false,
    this.labelText = 'Color Extensions',
  });

  /// is open
  final bool initiallyExpanded;

  /// label text
  final String labelText;

  /// label color - the actual color to demonstrate
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: allInsets2,
      initiallyExpanded: initiallyExpanded,
      minTileHeight: 8,
      title: Wrap(
        // Use spacing and runSpacing for desired gaps between elements
        spacing: spacing8,
        runSpacing: spacing4,
        // Vertically center children within each line
        crossAxisAlignment: WrapCrossAlignment.center,

        children: [
          // Color swatch display
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: borderRadius8,
              border: Border.all(color: black.withValues(alpha: 0.2)),
            ),
          ),

          const Spacing(of: spacing8),

          // label
          Text(
            black.toRGB,
            textAlign: TextAlign.start,
            style: boldTextStyle.copyWith(
              fontSize: fontSize20,
              color: black,
            ),
          ),

          // pill like chip to show required or optional
          // Category chip
          ValueChip(
            backColor: labelColor,
            textColor: labelColor.isLight ? black : white,
            valueText: labelText.inUpperCase,
            fadeBack: false,
          ),
        ],
      ),

      /// expanded styling
      shape: const RoundedRectangleBorder(borderRadius: borderRadius8),
      backgroundColor: transparent,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,

      /// collapsed
      collapsedBackgroundColor: transparent,
      collapsedShape: const RoundedRectangleBorder(borderRadius: borderRadius8),

      /// children
      childrenPadding: allInsets4,

      children: [
        Container(
          padding: allInsets16,
          decoration: BoxDecoration(
            borderRadius: borderRadius8,
            color: labelColor.withValues(alpha: 0.05),
            border: Border.all(
              color: labelColor.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            spacing: spacing4,
            children: labelColor.toTextLabels.map(
              (textLabel) {
                // title
                final title = textLabel.label;
                // value
                final value = textLabel.value;

                // For color transformation labels, show a color swatch
                final isColorLabel =
                    title == 'Complementary' ||
                    title == 'Grayscale' ||
                    title.contains('Opacity');

                return Row(
                  spacing: spacing16,
                  children: [
                    // title
                    Expanded(
                      child: Text(
                        '• $title',
                        style: regularTextStyle.copyWith(
                          fontSize: fontSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // If it's a color transformation, show color swatch
                    if (isColorLabel && value.startsWith('#'))
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: value.toColor,
                          borderRadius: borderRadius4,
                          border: Border.all(
                            color: black.withValues(alpha: 0.2),
                          ),
                        ),
                      ),

                    // value
                    Flexible(
                      child: SelectableText(
                        value,
                        textAlign: TextAlign.end,
                        style: regularTextStyle.copyWith(
                          fontSize: fontSize14,
                          color: labelColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
