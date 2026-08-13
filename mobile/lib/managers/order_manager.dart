import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderManager extends ChangeNotifier {
  static const String _ordersKey = 'orders';

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  int get orderCount => _orders.length;

  Future<void> loadOrders() async {
    final preferences = await SharedPreferences.getInstance();

    final savedOrders = preferences.getStringList(_ordersKey);

    if (savedOrders == null || savedOrders.isEmpty) {
      return;
    }

    _orders
      ..clear()
      ..addAll(
        savedOrders.map(
          (order) => Order.fromMap(
            jsonDecode(order) as Map<String, dynamic>,
          ),
        ),
      );

    notifyListeners();
  }

  Future<void> _saveOrders() async {
    final preferences = await SharedPreferences.getInstance();

    final savedOrders = _orders
        .map(
          (order) => jsonEncode(order.toMap()),
        )
        .toList();

    await preferences.setStringList(
      _ordersKey,
      savedOrders,
    );
  }

  Future<void> addOrder(Order order) async {
    _orders.insert(0, order);

    await _saveOrders();

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

  Future<void> updateOrderStatus(
    String orderId,
    String newStatus,
  ) async {
    final index = _orders.indexWhere(
      (order) => order.id == orderId,
    );

    if (index == -1) {
      return;
    }

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

    await _saveOrders();

    notifyListeners();
  }

  Future<void> clearOrders() async {
    _orders.clear();

    await _saveOrders();

    notifyListeners();
  }
}