// this will be a text widget as extension tile showing various extension methods
import 'package:flutter/cupertino.dart';

import '../../../app_exporter.dart';

/// advanced form label that also shows the hint
class NumTitle extends StatelessWidget {
  /// constructor
  const NumTitle({
    required this.labelText,
    super.key,
    this.initiallyExpanded = false,
    this.labelTextColor = black,
  });

  /// is open
  final bool initiallyExpanded;

  /// label text
  final num labelText;

  /// label color
  final Color labelTextColor;

  @override
  Widget build(BuildContext context) {
    const backColor = orange;

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
            labelText.format,
            textAlign: TextAlign.start,
            style: boldTextStyle.copyWith(
              fontSize: fontSize40,
              color: labelTextColor,
            ),
          ),
          const Spacing(of: spacing4),

          // pill like chip to show required or optional
          // Category chip
          ValueChip(
            backColor: backColor,
            textColor: white,
            valueText: 'Number Extensions'.inUpperCase,
            fadeBack: false,
          ),
        ],
      ),

      /// expanded styling
      shape: const RoundedRectangleBorder(borderRadius: borderRadius8),
      backgroundColor: transparent,
      // backgroundColor: appBackground,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,

      /// collapsed
      collapsedBackgroundColor: transparent,
      // collapsedBackgroundColor: whiteColor.withValues(alpha: .1),
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
            children: labelText.toTextLabels.map(
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
                        textAlign: TextAlign.start,
                        style: boldTextStyle.copyWith(
                          fontSize: fontSize14,
                          color: black,
                        ),
                      ),
                    ),

                    // arrow icon
                    const Icon(
                      CupertinoIcons.arrow_right,
                      size: 12,
                      color: black,
                    ),
                    // value
                    Flexible(
                      child: Text(
                        value,
                        textAlign: TextAlign.start,
                        style: normalTextStyle.copyWith(
                          fontSize: fontSize14,
                          color: labelTextColor,
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
