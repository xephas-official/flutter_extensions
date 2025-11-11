// this will be a text widget as extension tile showing various extension methods

import '../../../app_exporter.dart';

/// advanced form label that also shows the hint
class DateTitle extends StatelessWidget {
  /// constructor
  const DateTitle({
    required this.labelDate,
    super.key,
    this.initiallyExpanded = false,
    this.labelTextColor = black,
  });

  /// is open
  final bool initiallyExpanded;

  /// label date
  final DateTime labelDate;

  /// label color
  final Color labelTextColor;

  @override
  Widget build(BuildContext context) {
    const backColor = appGreen;

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
          // label
          Text(
            labelDate.toMonthDay,
            textAlign: TextAlign.start,
            style: boldTextStyle.copyWith(
              fontSize: fontSize24,
              color: labelTextColor,
            ),
          ),
          const Spacing(of: spacing4),

          // pill like chip to show required or optional
          // Category chip
          ValueChip(
            backColor: backColor,
            textColor: white,
            valueText: 'Date Extensions'.inUpperCase,
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
            color: backColor.withValues(alpha: .05),
            border: Border.all(
              color: backColor.withValues(alpha: .4),
            ),
          ),
          child: Column(
            spacing: spacing4,
            children: labelDate.toTextLabels.map(
              (textLabel) {
                // title
                final title = textLabel.label;
                // value
                final value = textLabel.value;

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

                    // value
                    Flexible(
                      child: SelectableText(
                        value,
                        textAlign: TextAlign.end,
                        style: regularTextStyle.copyWith(
                          fontSize: fontSize14,
                          color: backColor,
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
