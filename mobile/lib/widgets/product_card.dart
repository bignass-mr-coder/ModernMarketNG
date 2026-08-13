import 'package:flutter/material.dart';
import 'package:mobile/features/product/product_details_screen.dart';
import 'package:mobile/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final String image;
  final double rating;

  const ProductCard({
    super.key,
    required this.product,
    required this.image,
    this.rating = 4.8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
              product: product,
              image: image,
              rating: rating,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
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
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                '₦${product.price.toStringAsFixed(2)}',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                          product: product,
                          image: image,
                          rating: rating,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}