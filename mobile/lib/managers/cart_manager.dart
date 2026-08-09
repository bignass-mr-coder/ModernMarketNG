import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartManager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalQuantity {
    return _items.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );

    if (existingIndex >= 0) {
      final existingItem = _items[existingIndex];

      _items[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  void increaseQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.productId == productId,
    );

    if (index >= 0) {
      final item = _items[index];

      _items[index] = item.copyWith(
        quantity: item.quantity + 1,
      );

      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.productId == productId,
    );

    if (index >= 0) {
      final item = _items[index];

      if (item.quantity > 1) {
        _items[index] = item.copyWith(
          quantity: item.quantity - 1,
        );
      } else {
        _items.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.removeWhere(
      (item) => item.productId == productId,
    );

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}