import '../../../app_exporter.dart';

/// Widget displaying a product card
class ProductCard extends ConsumerWidget {
  /// Constructor
  const ProductCard({required this.product, super.key});

  /// Product to display
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final itemInCart = cartItems.any((item) => item.product.id == product.id);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () {
          // Could navigate to product details
          context.showSnackBar('Product details coming soon!');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image (emoji) with category badge overlay
              Stack(
                children: [
                  Hero(
                    tag: 'product_${product.id}',
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        product.imageUrl,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.category.toUpperCase(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Product details (name, description, price)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Product description
                    Text(
                      product.description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Price
                    Text(
                      product.price.toCurrency,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Add to cart button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(product);
                      context.showSnackBar('Added to cart!');
                    },
                    icon: Icon(
                      itemInCart ? Icons.check : Icons.add_shopping_cart,
                      size: 20,
                    ),
                    label: Text(itemInCart ? 'Added' : 'Add'),
                    style: FilledButton.styleFrom(
                      backgroundColor: itemInCart
                          ? context.colorScheme.surfaceContainerHighest
                          : context.colorScheme.primary,
                      foregroundColor: itemInCart
                          ? context.colorScheme.onSurface
                          : context.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
