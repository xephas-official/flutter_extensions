import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/exporter.dart';
import '../../../data/repositories/exporter.dart';
import '../../cart/data/providers/exporter.dart';
import '../../cart/presentation/cart_screen.dart';
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
          ).paddingOnly(right: 8),
        ],
      ),
      body: [
        // Category filter chips
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: 16.paddingHorizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;

              return FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                selectedColor: context.colorScheme.primaryContainer,
                checkmarkColor: context.colorScheme.onPrimaryContainer,
              ).paddingOnly(right: 8);
            },
          ),
        ),

        16.heightBox,

        // Products grid
        if (filteredProducts.isEmpty)
          const Text('No products in this category').center.expanded
        else
          GridView.builder(
            padding: 16.paddingAll,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.screenWidth > 600 ? 3 : 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: filteredProducts[index]);
            },
          ).expanded,
      ].toColumn(),
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
