import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/managers/product_manager.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/widgets/product_card.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductManager>().products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        if (products.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                'No products available yet.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final Product product = products[index];

              return ProductCard(
                product: product,
                image: _imageForCategory(product.category),
                rating: 4.8,
              );
            },
          ),
      ],
    );
  }

  String _imageForCategory(String category) {
    switch (category) {
      case 'Fashion':
        return 'assets/images/kaftan.jpg';

      case 'Electronics':
        return 'assets/images/iphone13.jpg';

      case 'Food':
        return 'assets/images/food.jpg';

      case 'Beauty':
        return 'assets/images/beauty.jpg';

      case 'Home':
        return 'assets/images/chair.jpg';

      case 'Agriculture':
        return 'assets/images/agriculture.jpg';

      default:
        return 'assets/images/kaftan.jpg';
    }
  }
}