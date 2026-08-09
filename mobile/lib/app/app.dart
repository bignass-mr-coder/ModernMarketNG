import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/navigation/bottom_navigation.dart';
import 'package:mobile/managers/cart_manager.dart';

class ModernMarketApp extends StatelessWidget {
  const ModernMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}