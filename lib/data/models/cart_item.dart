import 'product.dart';

/// Represents an item in the shopping cart with quantity
class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
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

  /// Factory constructor to create a CartItem from a map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int? ?? 1,
    );
  }

  /// Converts CartItem to map
  Map<String, dynamic> toMap() {
    return {'product': product.toMap(), 'quantity': quantity};
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
