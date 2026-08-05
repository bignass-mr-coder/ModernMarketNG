import 'package:flutter/material.dart';
import 'package:mobile/widgets/home_banner.dart';
import 'package:mobile/widgets/search_bar_widget.dart';
import 'package:mobile/widgets/home_categories.dart';
import 'package:mobile/widgets/featured_products.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Market NG'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
  HomeBanner(),

  SizedBox(height: 20),

  SearchBarWidget(),

  SizedBox(height: 24),

  HomeCategories(),

  SizedBox(height: 24),

  FeaturedProducts(),
],
        ),
      ),
    );
  }
}