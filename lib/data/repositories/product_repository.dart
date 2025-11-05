import '../../app_exporter.dart';

/// Repository for managing products
class ProductRepository {
  /// Sample products for the demo
  static List<Product> getSampleProducts() {
    // Helper to get random colors from randomColors
    List<Color> getRandomColors(int count) {
      final shuffled = List<Color>.from(randomColors)..shuffle();
      return shuffled.take(count).toList();
    }

    return [
      Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium noise-cancelling wireless headphones',
        price: 1299.99,
        imageUrl: '🎧',
        category: 'Electronics',
        dateManufactured: DateTime(2024, 6, 15),
        colors: getRandomColors(3),
      ),
      Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Feature-rich smartwatch with health tracking',
        price: 399.99,
        imageUrl: '⌚',
        category: 'Electronics',
        dateManufactured: DateTime(2024, 8, 22),
        colors: getRandomColors(4),
      ),
      Product(
        id: '3',
        name: 'Coffee Maker',
        description: 'Automatic coffee maker with timer',
        price: 8459.99,
        imageUrl: '☕',
        category: 'Home',
        dateManufactured: DateTime(2023, 11, 5),
        colors: getRandomColors(2),
      ),
      Product(
        id: '4',
        name: 'Running Shoes',
        description: 'Comfortable running shoes with great support',
        price: 1259.99,
        imageUrl: '👟',
        category: 'Sports',
        dateManufactured: DateTime(2024, 3, 10),
        colors: getRandomColors(5),
      ),
      Product(
        id: '5',
        name: 'Backpack',
        description: 'Durable backpack with laptop compartment',
        price: 59.99,
        imageUrl: '🎒',
        category: 'Accessories',
        dateManufactured: DateTime(2024, 1, 18),
        colors: getRandomColors(3),
      ),
      Product(
        id: '6',
        name: 'Water Bottle',
        description: 'Insulated water bottle keeps drinks cold',
        price: 224.99,
        imageUrl: '🍶',
        category: 'Sports',
        dateManufactured: DateTime(2024, 9, 7),
        colors: getRandomColors(4),
      ),
      Product(
        id: '7',
        name: 'Desk Lamp',
        description: 'LED desk lamp with adjustable brightness',
        price: 45.99,
        imageUrl: '💡',
        category: 'Home',
        dateManufactured: DateTime(2024, 5, 25),
        colors: getRandomColors(2),
      ),
      Product(
        id: '8',
        name: 'Bluetooth Speaker',
        description: 'Portable Bluetooth speaker with rich sound',
        price: 769.99,
        imageUrl: '🔊',
        category: 'Electronics',
        dateManufactured: DateTime(2024, 7, 12),
        colors: getRandomColors(3),
      ),
    ];
  }

  /// Get products by category
  static List<Product> getProductsByCategory(String category) {
    return getSampleProducts()
        .where((product) => product.category == category)
        .toList();
  }

  /// Get all categories
  static List<String> getCategories() {
    return getSampleProducts()
        .map((product) => product.category)
        .toSet()
        .toList()
      ..sort();
  }
}
