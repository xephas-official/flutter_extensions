import '../../app_exporter.dart';
import 'cart_action_button.dart';
import 'details_grid.dart';
import 'price_section.dart';
import 'product_appbar.dart';

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
          ProductAppBar(product: product),

          // Product details
          SliverPadding(
            padding: const EdgeInsets.all(spacing16),
            sliver: SliverList.list(
              children: [
                // Category chip
                ValueChip(
                  backColor: context.colorScheme.primaryContainer,
                  valueText: product.category.toUpperCase(),
                  fadeBack: false,
                  textColor: context.colorScheme.onPrimaryContainer,
                ),

                const Spacing(of: spacing24),

                // Price section
                PriceSection(
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
                DetailsGrid(product: product),

                const Spacing(of: spacing64 * 2),
              ],
            ),
          ),
        ],
      ),

      // Floating action button for cart
      floatingActionButton: CartActionButton(
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
            spacing: spacing8,
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
        .toList();
  }
}
