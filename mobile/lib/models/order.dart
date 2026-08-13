import 'package:mobile/models/cart_item.dart';

class Order {
  const Order({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
    this.status = 'Pending',
  });

  final String id;
  final String customerName;
  final String phoneNumber;
  final String address;
  final String deliveryMethod;
  final String paymentMethod;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime createdAt;
  final String status;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'address': address,
      'deliveryMethod': deliveryMethod,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      customerName: map['customerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      deliveryMethod: map['deliveryMethod'] as String,
      paymentMethod: map['paymentMethod'] as String,
      items: (map['items'] as List)
          .map(
            (item) => CartItem.fromMap(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
      subtotal: (map['subtotal'] as num).toDouble(),
      deliveryFee: (map['deliveryFee'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: map['status'] as String? ?? 'Pending',
    );
  }
}