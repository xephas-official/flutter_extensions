import '../../app_exporter.dart';

/// Represents a product in the shopping cart
class Product {
  /// Constructor
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.dateManufactured,
    this.category = 'General',
    this.colors = const [],
    this.inStock = true,
  });

  /// Factory constructor to create a Product from a map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] as String? ?? '',
      category: map['category'] as String? ?? 'General',
      dateManufactured: map['dateManufactured'] != null
          ? DateTime.parse(map['dateManufactured'] as String)
          : DateTime.now(),
      colors:
          (map['colors'] as List<dynamic>?)
              ?.map((c) => Color(c as int))
              .toList() ??
          [],
      inStock: map['inStock'] as bool? ?? true,
    );
  }

  /// Unique identifier for the product
  final String id;

  /// Name of the product
  final String name;

  /// Description of the product
  final String description;

  /// Price of the product
  final double price;

  /// Image URL of the product
  final String imageUrl;

  /// Category of the product
  final String category;

  /// Date when the product was manufactured
  final DateTime dateManufactured;

  /// Available colors for the product
  final List<Color> colors;

  /// Whether the product is in stock
  final bool inStock;

  /// getter price text
  String get priceText => price.formatWithCommas;

  /// Converts Product to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'dateManufactured': dateManufactured.toIso8601String(),
      'colors': colors
          .map(
            (c) =>
                (c.a.toInt() << 24) |
                (c.r.toInt() << 16) |
                (c.g.toInt() << 8) |
                c.b.toInt(),
          )
          .toList(),
      'inStock': inStock,
    };
  }

  /// Creates a copy with updated fields
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    DateTime? dateManufactured,
    List<Color>? colors,
    bool? inStock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      dateManufactured: dateManufactured ?? this.dateManufactured,
      colors: colors ?? this.colors,
      inStock: inStock ?? this.inStock,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }
}
