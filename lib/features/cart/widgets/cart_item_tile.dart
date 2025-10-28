import '../../../app_exporter.dart';

/// Widget displaying a single cart item
class CartItemTile extends ConsumerWidget {
  /// Constructor
  const CartItemTile({required this.item, super.key});

  /// Cart item to display
  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product image (emoji)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: borderRadius12,
              ),
              alignment: Alignment.center,
              child: Text(
                item.product.imageUrl,
                style: baseFont.copyWith(fontSize: 48),
              ),
            ),

            const SizedBox(width: 12),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: context.textTheme.titleMedium?.merge(
                      boldTextStyle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product.description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        )
                        .merge(regularTextStyle),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.product.price.toCurrency,
                    style: context.textTheme.titleMedium
                        ?.copyWith(
                          color: context.colorScheme.primary,
                        )
                        .merge(boldTextStyle),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Quantity controls
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement button
                IconButton(
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .decrementQuantity(item.product.id);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  color: context.colorScheme.error,
                ),

                // Quantity display
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      '${item.quantity}',
                      style: context.textTheme.titleLarge?.merge(
                        boldTextStyle,
                      ),
                    ),
                  ),
                ),

                // Increment button
                IconButton(
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .incrementQuantity(item.product.id);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  color: context.colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
