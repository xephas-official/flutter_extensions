import '../../app_exporter.dart';

/// Cart action button widget
class CartActionButton extends ConsumerWidget {
  /// Constructor
  const CartActionButton({
    required this.product,
    required this.itemInCart,
    required this.quantity,
    super.key,
  });

  /// product
  final Product product;

  /// is in cart
  final bool itemInCart;

  /// quantity
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: context.screenWidth * 0.9,
      padding: const EdgeInsets.symmetric(
        horizontal: spacing16,
        vertical: spacing12,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: borderRadius16,
        boxShadow: [
          BoxShadow(
            color: black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: itemInCart
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Decrease quantity
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      ref
                          .read(cartProvider.notifier)
                          .updateQuantity(
                            product.id,
                            quantity - 1,
                          );
                    } else {
                      ref.read(cartProvider.notifier).removeProduct(product.id);
                    }
                  },
                  icon: Icon(
                    quantity > 1 ? Icons.remove_circle : Icons.delete,
                    color: quantity > 1 ? black : Colors.red,
                  ),
                ),

                // Quantity display
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Quantity',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: context.textTheme.titleLarge?.merge(boldTextStyle),
                    ),
                  ],
                ),

                // Increase quantity
                IconButton(
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .updateQuantity(
                          product.id,
                          quantity + 1,
                        );
                  },
                  icon: const Icon(Icons.add_circle, color: appGreen),
                ),
              ],
            )
          : FilledButton.icon(
              onPressed: () {
                ref.read(cartProvider.notifier).addProduct(product);
                context.showSnackBar('${product.name} added to cart!');
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text(
                'Add to Cart',
                style: boldTextStyle,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: black,
                foregroundColor: white,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: borderRadius12,
                ),
              ),
            ),
    );
  }
}
