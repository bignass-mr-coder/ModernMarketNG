import 'package:flutter/material.dart';
import 'package:mobile/widgets/product_info.dart';
import 'package:mobile/widgets/seller_card.dart';
import 'package:mobile/widgets/product_gallery.dart';
import 'package:mobile/widgets/product_delivery_card.dart';
import 'package:mobile/widgets/product_specifications.dart';
import 'package:mobile/widgets/product_reviews.dart';
class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final double rating;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite_border),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProductInfo(
  name: widget.name,
  price: widget.price,
  rating: widget.rating,
),

const SizedBox(height: 20),

ProductGallery(
  image: widget.image,
  heroTag: widget.name,
),

            const SizedBox(height: 25),

           const SellerCard(),
           
const SizedBox(height: 24),

const ProductDeliveryCard(),

const SizedBox(height: 24),

const ProductSpecifications(),

const SizedBox(height: 24),

ProductReviews(),

const SizedBox(height: 24),

const Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: Text(
    "Description",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Premium quality product available on Modern Market NG. Carefully selected from trusted sellers across Nigeria. Fast delivery and secure payment guaranteed.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Quantity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            Row(
              children: [

                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle, size: 30),
                ),

                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, size: 30),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on),
                  label: const Text("Buy Now"),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}