// Demonstrates traditional function-based approach for string manipulation
import 'package:flutter/cupertino.dart';

import '../../../app_exporter.dart';
import '../extensions/string_functions.dart';

/// Widget demonstrating function-based string manipulation.
///
/// This widget shows the traditional approach of using functions instead of
/// extensions. Notice how much more verbose and repetitive the code becomes:
/// - Must pass the string as a parameter to every function
/// - Cannot chain operations naturally
/// - Less readable and harder to maintain
///
/// Compare this with [StringTitle] to see the advantages of extensions.
class StringFunctionsTitle extends StatefulWidget {
  /// constructor
  const StringFunctionsTitle({
    required this.labelText,
    super.key,
    this.labelTextColor = black,
  });

  /// label text
  final String labelText;

  /// label color
  final Color labelTextColor;

  @override
  State<StringFunctionsTitle> createState() => _StringFunctionsTitleState();
}

class _StringFunctionsTitleState extends State<StringFunctionsTitle> {
  bool isExpanded = false;
  bool showChip = true;

  @override
  Widget build(BuildContext context) {
    // Notice: We have to call stringToTextLabels() function and pass the
    // string as parameter, instead of using widget.labelText.toTextLabels
    // This is more verbose and breaks the natural flow of code
    final textLabels = stringToTextLabels(widget.labelText);

    return ExpansionTile(
      tilePadding: allInsets2,
      initiallyExpanded: isExpanded,
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
          // Even here, notice we can't use showChip.toggle with functions
          // We have to manually negate it
          showChip = !showChip;
        });
      },
      minTileHeight: 8,
      title: Wrap(
        spacing: spacing8,
        runSpacing: spacing4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // label
          Text(
            widget.labelText,
            textAlign: TextAlign.start,
            style: boldTextStyle.copyWith(
              fontSize: fontSize20,
              color: widget.labelTextColor,
            ),
          ),

          // Category chip
          // Notice: We have to call toUpperCaseWithSpaces() function
          // instead of using 'String Functions'.inUpperCase
          if (showChip)
            ValueChip(
              backColor: orange,
              textColor: white,
              valueText: toUpperCaseWithSpaces('String Functions'),
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
            color: orange.withValues(alpha: .05),
            border: Border.all(
              color: orange.withValues(alpha: .4),
            ),
          ),
          child: Column(
            spacing: spacing4,
            // Using the pre-computed textLabels list
            children: textLabels.map(
              (textLabel) {
                final title = textLabel.label;
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
                          color: widget.labelTextColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),

        // Add explanation of the disadvantages
        const Spacing(of: spacing8),
        Container(
          padding: allInsets12,
          decoration: BoxDecoration(
            borderRadius: borderRadius8,
            color: red.withValues(alpha: .1),
            border: Border.all(
              color: red.withValues(alpha: .6),
              width: 2,
            ),
          ),
          child: Column(
            spacing: spacing8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚠️ Function Approach Disadvantages',
                style: boldTextStyle.copyWith(
                  fontSize: fontSize16,
                  color: red,
                ),
              ),
              Text(
                '• Must pass string as parameter to every function\n'
                '• Cannot chain operations naturally\n'
                '• More verbose and repetitive code\n'
                '• Less discoverable (no IDE autocomplete)\n'
                '• Breaks natural left-to-right reading flow\n'
                '• Example: toTitleCase(toSnakeCase(text)) vs text.inSnakeCase.inTitleCase',
                style: normalTextStyle.copyWith(
                  fontSize: fontSize14,
                  color: black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
