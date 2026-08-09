import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String image;
  final String heroTag;

  const ProductImage({
    super.key,
    required this.image,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        width: double.infinity,
        height: 420,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
  image,
  width: double.infinity,
  height: double.infinity,
  fit: BoxFit.cover,
),
          ),
        ),
      ),
    );
  }
}