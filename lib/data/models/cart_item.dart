import 'product.dart';

/// Represents an item in the shopping cart with quantity
class CartItem {
  /// Constructor
  const CartItem({required this.product, required this.quantity});

  /// Factory constructor to create a CartItem from a map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int? ?? 1,
    );
  }

  /// product associated with the cart item
  final Product product;

  /// quantity of the product in the cart
  final int quantity;

  /// Creates a copy with updated fields
  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Returns the total price for this cart item
  double get totalPrice => product.price * quantity;

  /// Converts CartItem to map
  Map<String, dynamic> toMap() {
    return {'product': product.toMap(), 'quantity': quantity};
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, quantity: $quantity)';
  }
}
