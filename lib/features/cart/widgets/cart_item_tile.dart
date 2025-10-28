import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/exporter.dart';
import '../../../data/models/exporter.dart';
import '../providers/exporter.dart';

/// Widget displaying a single cart item
class CartItemTile extends ConsumerWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product image (emoji)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                item.product.imageUrl,
                style: const TextStyle(fontSize: 48),
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
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product.description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.product.price.toCurrency,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
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
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
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
