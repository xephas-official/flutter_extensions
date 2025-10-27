import '../models/exporter.dart';

/// Repository for managing products
class ProductRepository {
  /// Sample products for the demo
  static List<Product> getSampleProducts() {
    return [
      const Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium noise-cancelling wireless headphones',
        price: 299.99,
        imageUrl: '🎧',
        category: 'Electronics',
      ),
      const Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Feature-rich smartwatch with health tracking',
        price: 399.99,
        imageUrl: '⌚',
        category: 'Electronics',
      ),
      const Product(
        id: '3',
        name: 'Coffee Maker',
        description: 'Automatic coffee maker with timer',
        price: 89.99,
        imageUrl: '☕',
        category: 'Home',
      ),
      const Product(
        id: '4',
        name: 'Running Shoes',
        description: 'Comfortable running shoes with great support',
        price: 129.99,
        imageUrl: '👟',
        category: 'Sports',
      ),
      const Product(
        id: '5',
        name: 'Backpack',
        description: 'Durable backpack with laptop compartment',
        price: 59.99,
        imageUrl: '🎒',
        category: 'Accessories',
      ),
      const Product(
        id: '6',
        name: 'Water Bottle',
        description: 'Insulated water bottle keeps drinks cold',
        price: 24.99,
        imageUrl: '🍶',
        category: 'Sports',
      ),
      const Product(
        id: '7',
        name: 'Desk Lamp',
        description: 'LED desk lamp with adjustable brightness',
        price: 45.99,
        imageUrl: '💡',
        category: 'Home',
      ),
      const Product(
        id: '8',
        name: 'Bluetooth Speaker',
        description: 'Portable Bluetooth speaker with rich sound',
        price: 79.99,
        imageUrl: '🔊',
        category: 'Electronics',
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
