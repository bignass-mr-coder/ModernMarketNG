import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final double rating;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ),

            Expanded(
              child: Center(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(rating.toString()),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              price,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}