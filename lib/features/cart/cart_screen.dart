import '../../app_exporter.dart';
import 'widgets/exporter.dart';

/// Shopping cart screen
class CartScreen extends ConsumerWidget {
  /// Constructor
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalPriceProvider);
    final itemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: boldTextStyle.copyWith(
            fontSize: 18,
            color: black,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text(
                      'Are you sure you want to remove all items?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop<void>(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).clearCart();
                          context.pop<void>();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Clear cart',
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? const EmptyCart()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (context, index) => const Spacing(of: 12),
              itemBuilder: (context, index) {
                return CartItemTile(item: cartItems[index]);
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: circularRadius8,
                  topRight: circularRadius8,
                ),
                border: const Border(
                  top: BorderSide(color: appColor),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Items',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(
                                      color:
                                          context.colorScheme.onSurfaceVariant,
                                    )
                                    .merge(regularTextStyle),
                              ),
                              Text(
                                '$itemCount',
                                style: context.textTheme.titleMedium?.merge(
                                  boldTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(
                                    color: context.colorScheme.onSurfaceVariant,
                                  )
                                  .merge(regularTextStyle),
                            ),
                            Text(
                              totalPrice.formatWithCommas,
                              style: context.textTheme.headlineSmall
                                  ?.copyWith(
                                    color: context.colorScheme.primary,
                                  )
                                  .merge(boldTextStyle),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacing(of: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: () {
                          context.showSnackBar(
                            'Checkout feature coming soon!',
                            duration: const Duration(seconds: 3),
                          );
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
