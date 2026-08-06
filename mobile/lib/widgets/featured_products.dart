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
          childAspectRatio: 0.68,
          children: const [

            ProductCard(
              image: 'assets/images/kaftan.jpg',
              name: 'Morocco Kaftan',
              price: '₦25,000',
              rating: 4.8,
            ),

            ProductCard(
              image: 'assets/images/iphone13.jpg',
              name: 'iPhone 13',
              price: '₦650,000',
              rating: 4.9,
            ),

            ProductCard(
              image: 'assets/images/laptop.jpg',
              name: 'Laptop',
              price: '₦420,000',
              rating: 4.7,
            ),

            ProductCard(
              image: 'assets/images/chair.jpg',
              name: 'Office Chair',
              price: '₦55,000',
              rating: 3.8,
            ),
          ],
        ),
      ],
    );
  }
}