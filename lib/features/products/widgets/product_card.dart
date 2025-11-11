import 'package:flutter/cupertino.dart';

import '../../../app_exporter.dart';
import '../../details/product_detail_screen.dart';

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
          context.push<void>(ProductDetailScreen(product: product));
        },
        borderRadius: borderRadius12,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image (emoji) with category badge overlay
              Hero(
                tag: 'product_${product.id}',
                child: Material(
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
              ),

              const Spacing(of: 12),

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

                    const Spacing(of: 4),

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

                    const Spacing(of: 8),

                    ValueChip(
                      backColor: black.withValues(alpha: .1),
                      valueText: product.category,
                      fadeBack: false,
                      textColor: black,
                    ),

                    const Spacing(of: 8),

                    // Price
                    Text(
                      product.price.toUSD,
                      style: context.textTheme.titleLarge
                          ?.copyWith(
                            color: itemInCart
                                ? appGreen
                                : context.colorScheme.primary,
                          )
                          .merge(boldTextStyle),
                    ),
                  ],
                ),
              ),

              const Spacing(of: 12),

              // Add to cart button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    isSelected: itemInCart,
                    onPressed: () {
                      if (itemInCart) {
                        // Remove from cart
                        ref
                            .read(cartProvider.notifier)
                            .removeProduct(product.id);
                        // context.showSnackBar('Removed from cart');
                      } else {
                        // Add to cart
                        ref.read(cartProvider.notifier).addProduct(product);
                        // context.showSnackBar('Added to cart!');
                      }
                    },
                    splashColor: itemInCart ? appGreen : black,
                    selectedIcon: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: appGreen.withValues(alpha: .2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: appGreen,
                        size: 28,
                      ),
                    ),
                    icon: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.cart_fill_badge_plus,
                        color: white,
                        size: 24,
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
