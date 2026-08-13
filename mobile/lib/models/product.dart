class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.stockQuantity,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final String name;
  final double price;
  final String category;
  final int stockQuantity;
  final String description;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'stockQuantity': stockQuantity,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
      stockQuantity: map['stockQuantity'] as int,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}