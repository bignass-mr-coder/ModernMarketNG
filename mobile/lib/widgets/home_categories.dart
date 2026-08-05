import 'package:flutter/material.dart';
import 'package:mobile/widgets/category_card.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Categories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: const [
            CategoryCard(
              icon: Icons.checkroom,
              title: 'Fashion',
            ),
            CategoryCard(
              icon: Icons.phone_android,
              title: 'Electronics',
            ),
            CategoryCard(
              icon: Icons.directions_car,
              title: 'Vehicles',
            ),
            CategoryCard(
              icon: Icons.home,
              title: 'Property',
            ),
          ],
        ),
      ],
    );
  }
}