import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductManager extends ChangeNotifier {
  static const String _productsKey = 'products';

  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  int get productCount => _products.length;

  Future<void> loadProducts() async {
    final preferences = await SharedPreferences.getInstance();

    final savedProducts = preferences.getStringList(_productsKey);

    if (savedProducts == null || savedProducts.isEmpty) {
      return;
    }

    _products
      ..clear()
      ..addAll(
        savedProducts.map(
          (product) => Product.fromMap(
            jsonDecode(product) as Map<String, dynamic>,
          ),
        ),
      );

    notifyListeners();
  }

  Future<void> _saveProducts() async {
    final preferences = await SharedPreferences.getInstance();

    final savedProducts = _products
        .map((product) => jsonEncode(product.toMap()))
        .toList();

    await preferences.setStringList(
      _productsKey,
      savedProducts,
    );
  }

  Future<void> addProduct(Product product) async {
    _products.add(product);

    await _saveProducts();

    notifyListeners();
  }

  Future<void> removeProduct(String productId) async {
    _products.removeWhere(
      (product) => product.id == productId,
    );

    await _saveProducts();

    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final index = _products.indexWhere(
      (product) => product.id == updatedProduct.id,
    );

    if (index == -1) {
      return;
    }

    _products[index] = updatedProduct;

    await _saveProducts();

    notifyListeners();
  }

  Future<void> clearProducts() async {
    _products.clear();

    await _saveProducts();

    notifyListeners();
  }
}