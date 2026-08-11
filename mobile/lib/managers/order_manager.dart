import 'package:flutter/foundation.dart';

import 'package:mobile/models/order.dart';

class OrderManager extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  Order? getOrderById(String orderId) {
    for (final order in _orders) {
      if (order.id == orderId) {
        return order;
      }
    }

    return null;
  }

  void updateOrderStatus(
    String orderId,
    String newStatus,
  ) {
    final index = _orders.indexWhere(
      (order) => order.id == orderId,
    );

    if (index == -1) return;

    final oldOrder = _orders[index];

    _orders[index] = Order(
      id: oldOrder.id,
      customerName: oldOrder.customerName,
      phoneNumber: oldOrder.phoneNumber,
      address: oldOrder.address,
      deliveryMethod: oldOrder.deliveryMethod,
      paymentMethod: oldOrder.paymentMethod,
      items: oldOrder.items,
      subtotal: oldOrder.subtotal,
      deliveryFee: oldOrder.deliveryFee,
      total: oldOrder.total,
      createdAt: oldOrder.createdAt,
      status: newStatus,
    );

    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}