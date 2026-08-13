class CartItem {
  const CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.image,
    required this.quantity,
  });

  final String productId;
  final String productName;
  final String price;
  final String image;
  final int quantity;

  CartItem copyWith({
    String? productId,
    String? productName,
    String? price,
    String? image,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }
}