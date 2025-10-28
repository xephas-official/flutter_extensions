import '../../../app_exporter.dart';
import '../../../global/widgets/value_chip.dart';

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

    return AnimatedContainer(
      duration: halfSecond,
      // margin: verticalInsets8,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: itemInCart ? appGreen.withValues(alpha: .1) : white,
        borderRadius: borderRadius12,
        border: Border.all(
          color: itemInCart ? appGreen : black.withValues(alpha: .2),
          width: .8,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Could navigate to product details
          context.showSnackBar('Product details coming soon!');
        },
        borderRadius: borderRadius12,
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
                        borderRadius: borderRadius12,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        product.imageUrl,
                        style: baseFont.copyWith(fontSize: 48),
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
                      style: context.textTheme.titleMedium?.merge(
                        boldTextStyle,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Product description
                    Text(
                      product.description,
                      style: context.textTheme.bodySmall
                          ?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          )
                          .merge(regularTextStyle),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    ValueChip(
                      backColor: context.colorScheme.primaryContainer,
                      valueText: product.category,
                      fadeBack: false,
                      textColor: context.colorScheme.onPrimaryContainer,
                    ),

                    const SizedBox(height: 8),

                    // Price
                    Text(
                      product.price.toCurrency,
                      style: context.textTheme.titleLarge
                          ?.copyWith(
                            color: context.colorScheme.primary,
                          )
                          .merge(boldTextStyle),
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
