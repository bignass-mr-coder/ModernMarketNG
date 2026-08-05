import 'package:flutter/material.dart';
import 'package:mobile/navigation/bottom_navigation.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/navigation/bottom_navigation.dart';
class ModernMarketApp extends StatelessWidget {
  const ModernMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    );
  }
}