import 'package:flutter/foundation.dart';

import 'package:mobile/models/product.dart';
import 'package:mobile/models/seller.dart';

class SellerManager extends ChangeNotifier {
  Seller? _seller;

  final List<Product> _products = [];

  Seller? get seller => _seller;

  bool get hasSeller => _seller != null;

  List<Product> get products => List.unmodifiable(_products);

  void registerSeller(Seller seller) {
    _seller = seller;
    notifyListeners();
  }

  void updateSeller(Seller seller) {
    _seller = seller;
    notifyListeners();
  }

  void clearSeller() {
    _seller = null;
    _products.clear();
    notifyListeners();
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