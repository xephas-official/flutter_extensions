import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/exporter.dart';
import '../../../data/models/exporter.dart';
import '../../cart/providers/exporter.dart';

/// Widget displaying a product card
class ProductCard extends ConsumerWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final itemInCart = cartItems.any((item) => item.product.id == product.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: [
        // Product image (emoji)
        Text(product.imageUrl, style: const TextStyle(fontSize: 64))
            .container(
              height: 120,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
              ),
              alignment: Alignment.center,
            )
            .hero('product_${product.id}'),

        // Product details
        [
          // Category badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: 12.borderRadius,
            ),
            child: Text(
              product.category,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          8.heightBox,

          // Product name
          Text(
            product.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          4.heightBox,

          // Product description
          Text(
            product.description,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          8.heightBox,

          // Price and Add button
          [
            Text(
              product.price.toCurrency,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ).expanded,
            FilledButton.icon(
              onPressed: () {
                ref.read(cartProvider.notifier).addProduct(product);
                context.showSnackBar('Added to cart!');
              },
              icon: Icon(itemInCart ? Icons.check : Icons.add_shopping_cart),
              label: Text(itemInCart ? 'Added' : 'Add'),
              style: FilledButton.styleFrom(
                backgroundColor: itemInCart
                    ? context.colorScheme.surfaceContainerHighest
                    : context.colorScheme.primary,
                foregroundColor: itemInCart
                    ? context.colorScheme.onSurface
                    : context.colorScheme.onPrimary,
              ),
            ),
          ].toRow(),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(12),
      ].toColumn(),
    ).onTap(() {
      // Could navigate to product details
      context.showSnackBar('Product details coming soon!');
    }, borderRadius: 12.borderRadius);
  }
}
