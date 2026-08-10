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
}