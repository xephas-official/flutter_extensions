import '../../app_exporter.dart';

/// Price section widget
class PriceSection extends StatelessWidget {
  /// constructor
  const PriceSection({
    required this.price,
    required this.itemInCart,
    super.key,
  });

  /// price
  final double price;

  /// is in cart
  final bool itemInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: allInsets8,
      decoration: BoxDecoration(
        color: itemInCart
            ? appGreen.withValues(alpha: 0.1)
            : blueAccent.withValues(alpha: 0.05),
        borderRadius: borderRadius12,
        border: Border.all(
          color: itemInCart ? appGreen : context.colorScheme.outline,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacing(of: spacing4),
                Text(
                  'Price',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                NumTitle(labelText: price),
              ],
            ),
          ),
          if (itemInCart)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: spacing12,
                vertical: spacing8,
              ),
              decoration: const BoxDecoration(
                color: appGreen,
                borderRadius: borderRadius8,
              ),
              child: Row(
                children: [
                  const Icon(Icons.check, color: white, size: spacing16),
                  const Spacing(of: spacing4),
                  Text(
                    'In Cart',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
