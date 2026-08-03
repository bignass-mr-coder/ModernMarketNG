import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';

class ModernMarketNGApp extends StatelessWidget {
  const ModernMarketNGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Market NG',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}