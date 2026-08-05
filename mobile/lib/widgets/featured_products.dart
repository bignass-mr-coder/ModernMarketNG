import 'package:flutter/material.dart';
import 'package:mobile/widgets/product_card.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
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
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
          children: const [
            ProductCard(
              name: 'Morocco Kaftan',
              price: '₦25,000',
              icon: Icons.checkroom,
            ),
            ProductCard(
              name: 'iPhone 13',
              price: '₦650,000',
              icon: Icons.phone_iphone,
            ),
            ProductCard(
              name: 'Laptop',
              price: '₦420,000',
              icon: Icons.laptop,
            ),
            ProductCard(
              name: 'Office Chair',
              price: '₦55,000',
              icon: Icons.chair,
            ),
          ],
        ),
      ],
    );
  }
}