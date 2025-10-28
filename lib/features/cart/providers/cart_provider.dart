import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/exporter.dart';

/// Cart state notifier
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  /// Add a product to cart
  void addProduct(Product product) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Product exists, increment quantity
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + 1,
      );
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Add new product
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  /// Remove a product from cart
  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  /// Update quantity of a product
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final updatedItem = state[index].copyWith(quantity: quantity);
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    }
  }

  /// Increment quantity
  void incrementQuantity(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      updateQuantity(productId, state[index].quantity + 1);
    }
  }

  /// Decrement quantity
  void decrementQuantity(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      updateQuantity(productId, state[index].quantity - 1);
    }
  }

  /// Clear cart
  void clearCart() {
    state = [];
  }

  /// Get total items count
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);

  /// Get total price
  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
}

/// Cart provider
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Cart item count provider
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

/// Cart total price provider
final cartTotalPriceProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.totalPrice);
});
