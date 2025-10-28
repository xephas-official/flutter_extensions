import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/exporter.dart';
import '../../core/extensions/exporter.dart';
import '../../data/repositories/exporter.dart';
import '../cart/providers/exporter.dart';
import '../cart/cart_screen.dart';
import 'providers/exporter.dart';
import 'widgets/exporter.dart';

/// Products listing screen
class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ProductRepository.getSampleProducts();
    final categories = ['All', ...ProductRepository.getCategories()];
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products.where((p) => p.category == selectedCategory).toList();

    final itemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Extensions Shop')),
      body: Column(
        children: [
          // Category filter chips
          Container(
            height: kToolbarHeight,
            alignment: Alignment.center,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(categories.length, (index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  final isFirst = index == 0;
                  final isLast = index == (categories.length - 1);

                  final backColor = navyBlue.withOpacity(0.1);
                  const selectedColor = navyBlue;
                  const textColor = Colors.white;

                  final enabledPadding = isSelected
                      ? const EdgeInsets.symmetric(horizontal: 4)
                      : const EdgeInsets.symmetric(horizontal: 2);

                  final padding = isFirst
                      ? const EdgeInsets.only(left: 16, right: 2)
                      : isLast
                      ? const EdgeInsets.only(left: 2, right: 16)
                      : enabledPadding;

                  return AnimatedPadding(
                    duration: const Duration(seconds: 1),
                    padding: padding,
                    key: Key(category),
                    child: FilterChip(
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: isSelected ? 2 : 0,
                          color: isSelected ? selectedColor : backColor,
                        ),
                      ),
                      pressElevation: 10,
                      tooltip: category,
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? textColor : selectedColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: backColor,
                      avatar: isSelected
                          ? const CircleAvatar(
                              backgroundColor: textColor,
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: selectedColor,
                              ),
                            )
                          : null,
                      showCheckmark: false,
                      selectedColor: selectedColor,
                      selected: isSelected,
                      onSelected: (selected) {
                        ref.read(selectedCategoryProvider.notifier).state =
                            category;
                      },
                    ),
                  );
                }),
              ),
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
