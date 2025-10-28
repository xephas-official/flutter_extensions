import 'package:flutter/material.dart';
import '../../../core/extensions/exporter.dart';

/// Widget displayed when cart is empty
class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(40),
            child: const Icon(Icons.shopping_cart_outlined, size: 120),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to get started',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
