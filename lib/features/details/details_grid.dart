import '../../app_exporter.dart';

/// Details grid widget
class DetailsGrid extends StatelessWidget {
  /// constructor
  const DetailsGrid({required this.product, super.key});

  /// product
  final Product product;

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Product ID', 'value': product.id},
      {'label': 'Category', 'value': product.category},
      {'label': 'Availability', 'value': 'In Stock'},
      {'label': 'Rating', 'value': '4.5 ⭐'},
    ];

    return Wrap(
      children: details.map((detail) {
        return Container(
          width: (context.screenWidth - 64) / 2,
          margin: const EdgeInsets.only(
            bottom: spacing12,
            right: spacing12,
          ),
          padding: const EdgeInsets.all(spacing12),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: borderRadius8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                detail['label']!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacing(of: spacing4),
              Text(
                detail['value']!,
                style: context.textTheme.bodyMedium?.merge(boldTextStyle),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
