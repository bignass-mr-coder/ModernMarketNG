import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/models/seller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerManager extends ChangeNotifier {
  static const String _sellerKey = 'current_seller';

  Seller? _seller;

  final List<Product> _products = [];

  Seller? get seller => _seller;

  bool get hasSeller => _seller != null;

  List<Product> get products => List.unmodifiable(_products);

  Future<void> loadSeller() async {
    final preferences =
        await SharedPreferences.getInstance();

    final savedSeller =
        preferences.getString(_sellerKey);

    if (savedSeller == null ||
        savedSeller.isEmpty) {
      return;
    }

    _seller = Seller.fromMap(
      jsonDecode(savedSeller)
          as Map<String, dynamic>,
    );

    notifyListeners();
  }

  Future<void> registerSeller(
    Seller seller,
  ) async {
    _seller = seller;

    await _saveSeller();

    notifyListeners();
  }

  Future<void> updateSeller(
    Seller seller,
  ) async {
    _seller = seller;

    await _saveSeller();

    notifyListeners();
  }

  Future<void> clearSeller() async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.remove(_sellerKey);

    _seller = null;
    _products.clear();

    notifyListeners();
  }

  Future<void> _saveSeller() async {
    if (_seller == null) {
      return;
    }

    final preferences =
        await SharedPreferences.getInstance();

    await preferences.setString(
      _sellerKey,
      jsonEncode(_seller!.toMap()),
    );
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String productId) {
    _products.removeWhere(
      (product) => product.id == productId,
    );

    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = _products.indexWhere(
      (product) => product.id == updatedProduct.id,
    );

    if (index == -1) {
      return;
    }

    _products[index] = updatedProduct;

    notifyListeners();
  }
}