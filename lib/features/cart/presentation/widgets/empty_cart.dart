import 'package:flutter/material.dart';
import '../../../../core/extensions/exporter.dart';

/// Widget displayed when cart is empty
class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      const Icon(Icons.shopping_cart_outlined, size: 120).container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        padding: 40.paddingAll,
      ),
      24.heightBox,
      Text(
        'Your cart is empty',
        style: context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      8.heightBox,
      Text(
        'Add some products to get started',
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center).center;
  }
}
