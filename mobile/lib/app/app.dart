import 'package:flutter/material.dart';
import 'package:mobile/features/home/home_screen.dart';

class ModernMarketApp extends StatelessWidget {
  const ModernMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}