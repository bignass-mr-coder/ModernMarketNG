import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/navigation/bottom_navigation.dart';
import 'package:mobile/managers/cart_manager.dart';
import 'package:mobile/managers/order_manager.dart';
import 'package:mobile/managers/seller_manager.dart';
import 'package:mobile/managers/product_manager.dart';
class ModernMarketApp extends StatelessWidget {
  const ModernMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
  ChangeNotifierProvider(
    create: (_) => CartManager(),
  ),
  ChangeNotifierProvider(
  create: (_) => OrderManager()..loadOrders(),
),
  ChangeNotifierProvider(
    create: (_) => SellerManager(),
  ),
  ChangeNotifierProvider(
  create: (_) => ProductManager()..loadProducts(),
),
],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}