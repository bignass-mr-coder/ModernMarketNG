import 'package:flutter/material.dart';
import 'package:mobile/widgets/category_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.history),
              title: Text('Kaftan'),
            ),

            const ListTile(
              leading: Icon(Icons.history),
              title: Text('Shoes'),
            ),

            const ListTile(
              leading: Icon(Icons.history),
              title: Text('Wrist Watch'),
            ),

            const SizedBox(height: 24),

            const Text(
              'Popular Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
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
                    icon: Icons.chair,
                    title: 'Furniture',
                  ),
                  CategoryCard(
                    icon: Icons.restaurant,
                    title: 'Food',
                  ),
                  CategoryCard(
                    icon: Icons.computer,
                    title: 'Computers',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}