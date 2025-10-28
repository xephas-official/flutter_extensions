import '../../app_exporter.dart';
import '../cart/cart_screen.dart';
import 'widgets/exporter.dart';

/// Products listing screen
class ProductsScreen extends ConsumerWidget {
  /// Constructor
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
      appBar: AppBar(
        // backgroundColor: appColor,
        title: Text(
          'Extensions Shop',
          style: boldTextStyle.copyWith(
            fontSize: 18,
            color: black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: CategoryFilters(
            categories: categories,
            selectedCategory: selectedCategory,
          ),
        ),
      ),
      body: Column(
        children: [
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
              shape: const StadiumBorder(),
              backgroundColor: blue,
              foregroundColor: white,
              onPressed: () {
                context.push<void>(const CartScreen());
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text('View Cart ($itemCount)'),
            )
          : null,
    );
  }
}
