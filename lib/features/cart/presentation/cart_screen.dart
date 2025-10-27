import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/exporter.dart';
import '../data/providers/exporter.dart';
import 'widgets/exporter.dart';

/// Shopping cart screen
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalPriceProvider);
    final itemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text(
                      'Are you sure you want to remove all items?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).clearCart();
                          context.pop();
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
          : ListView.builder(
              padding: 16.paddingAll,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemTile(item: cartItems[index]);
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: 16.paddingAll,
              child: SafeArea(
                child: [
                  [
                    [
                          Text(
                            'Total Items',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '$itemCount',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                        .expanded,
                    [
                      Text(
                        'Total',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        totalPrice.toCurrency,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.end),
                  ].toRow(),
                  16.heightBox,
                  FilledButton(
                    onPressed: () {
                      context.showSnackBar(
                        'Checkout feature coming soon!',
                        duration: const Duration(seconds: 3),
                      );
                    },
                    child: const Text('Proceed to Checkout'),
                  ).container(width: double.infinity, height: 50),
                ].toColumn(),
              ),
            ),
    );
  }
}
