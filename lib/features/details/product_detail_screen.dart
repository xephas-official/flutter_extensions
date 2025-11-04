import '../../app_exporter.dart';

/// Product detail screen showcasing extension methods
class ProductDetailScreen extends ConsumerWidget {
  /// Constructor
  const ProductDetailScreen({required this.product, super.key});

  /// Product to display
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final itemInCart = cartItems.any((item) => item.product.id == product.id);
    final cartItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible app bar with hero image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: context.colorScheme.primary,
            foregroundColor: white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
                style: boldTextStyle.copyWith(
                  color: white,
                ),
              ),
              background: Hero(
                tag: 'product_${product.id}',
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.colorScheme.primary,
                          context.colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        product.imageUrl,
                        style: baseFont.copyWith(fontSize: 120),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Product details
          SliverPadding(
            padding: const EdgeInsets.all(spacing16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Category chip
                ValueChip(
                  backColor: context.colorScheme.primaryContainer,
                  valueText: product.category.toUpperCase(),
                  fadeBack: false,
                  textColor: context.colorScheme.onPrimaryContainer,
                ),

                const Spacing(of: spacing24),

                // Price section
                _PriceSection(
                  price: product.price,
                  itemInCart: itemInCart,
                ),

                const Spacing(of: spacing32),

                // Description section
                const StringTitle(labelText: 'Product Description'),

                const Spacing(of: spacing12),

                Text(
                  product.description,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),

                const Spacing(of: spacing32),

                // Features section (demonstrating list extensions)
                const StringTitle(labelText: 'Features'),

                const Spacing(of: spacing12),

                ..._buildFeaturesList(context),

                const Spacing(of: spacing32),

                // Product details grid
                const StringTitle(labelText: 'Details'),

                const Spacing(of: spacing12),
                _DetailsGrid(product: product),

                const Spacing(of: spacing64 * 2),
              ]),
            ),
          ),
        ],
      ),

      // Floating action button for cart
      floatingActionButton: _CartActionButton(
        product: product,
        itemInCart: itemInCart,
        quantity: cartItem.quantity,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Builds a list of product features demonstrating list extensions
  List<Widget> _buildFeaturesList(BuildContext context) {
    final features = [
      'High quality materials',
      'Fast shipping included',
      '30-day money-back guarantee',
      'Customer support 24/7',
    ];

    return features
        .map(
          (feature) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle,
                color: appGreen,
                size: spacing20,
              ),
              const Spacing(of: spacing8),
              Expanded(
                child: Text(
                  feature,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        )
        .toList()
        .divide(const Spacing(of: spacing8))
        .toList();
  }
}

/// Price section widget
class _PriceSection extends StatelessWidget {
  const _PriceSection({
    required this.price,
    required this.itemInCart,
  });

  final double price;
  final bool itemInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing16),
      decoration: BoxDecoration(
        color: itemInCart
            ? appGreen.withValues(alpha: 0.1)
            : context.colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius12,
        border: Border.all(
          color: itemInCart ? appGreen : context.colorScheme.outline,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacing(of: spacing4),
              Text(
                price.toCurrency,
                style: context.textTheme.displaySmall?.merge(boldTextStyle),
              ),
            ],
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

/// Details grid widget
class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid({required this.product});

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

/// Cart action button widget
class _CartActionButton extends ConsumerWidget {
  const _CartActionButton({
    required this.product,
    required this.itemInCart,
    required this.quantity,
  });

  final Product product;
  final bool itemInCart;
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
