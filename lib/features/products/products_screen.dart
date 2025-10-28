import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/extensions/exporter.dart';
import '../../data/repositories/exporter.dart';
import '../cart/providers/exporter.dart';
import '../cart/cart_screen.dart';
import 'widgets/exporter.dart';

/// Products listing screen
class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final products = ProductRepository.getSampleProducts();
    final categories = ['All', ...ProductRepository.getCategories()];
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products.where((p) => p.category == selectedCategory).toList();

    final itemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Extensions Shop'),
        actions: [
          // Cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  context.push(const CartScreen());
                },
              ),
              if (itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: context.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$itemCount',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Category filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: context.colorScheme.primaryContainer,
                    checkmarkColor: context.colorScheme.onPrimaryContainer,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Products list (inventory-style)
          if (filteredProducts.isEmpty)
            const Expanded(
              child: Center(child: Text('No products in this category')),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: filteredProducts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return ProductCard(product: filteredProducts[index]);
                },
              ),
            ),
        ],
      ),
      floatingActionButton: itemCount > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                context.push(const CartScreen());
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text('View Cart ($itemCount)'),
            )
          : null,
    );
  }
}
