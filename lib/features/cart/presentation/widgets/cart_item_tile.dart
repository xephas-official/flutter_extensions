import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/exporter.dart';
import '../../../../data/models/exporter.dart';
import '../../data/providers/exporter.dart';

/// Widget displaying a single cart item
class CartItemTile extends ConsumerWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: 8.paddingVertical,
      child: [
        // Product image (emoji)
        Text(
          item.product.imageUrl,
          style: const TextStyle(fontSize: 48),
        ).container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: 12.borderRadius,
          ),
          alignment: Alignment.center,
        ),

        12.widthBox,

        // Product details
        [
          Text(
            item.product.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          4.heightBox,
          Text(
            item.product.description,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          8.heightBox,
          Text(
            item.product.price.toCurrency,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).expanded,

        12.widthBox,

        // Quantity controls
        [
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
          Text(
            '${item.quantity}',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).container(width: 40, alignment: Alignment.center),

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
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.center).paddingAll(12),
    );
  }
}
