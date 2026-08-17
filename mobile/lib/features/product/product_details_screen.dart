import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/features/cart/cart_screen.dart';
import 'package:mobile/managers/cart_manager.dart';
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/widgets/product_delivery_card.dart';
import 'package:mobile/widgets/product_gallery.dart';
import 'package:mobile/widgets/product_info.dart';
import 'package:mobile/widgets/product_reviews.dart';
import 'package:mobile/widgets/product_specifications.dart';
import 'package:mobile/widgets/seller_card.dart';
import 'package:mobile/features/checkout/checkout_screen.dart';
import 'package:mobile/managers/product_manager.dart';
import 'package:mobile/widgets/product_card.dart';
class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String image;
  final double rating;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.image,
    this.rating = 4.8,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  int quantity = 1;

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

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 12,
                offset: Offset(0, -3),
                color: Colors.black12,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: product.stockQuantity <= 0
                      ? null
                      : () {
                          final cartItem = CartItem(
                            productId: product.id,
                            productName: product.name,
                            price:
                                '₦${product.price.toStringAsFixed(2)}',
                            image: widget.image,
                            quantity: quantity,
                          );

                          context
                              .read<CartManager>()
                              .addItem(cartItem);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart'),
                            ),
                          );
                        },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: product.stockQuantity <= 0
                      ? null
                      : () {
                          final buyNowItem = CartItem(
                            productId: product.id,
                            productName: product.name,
                            price:
                                '₦${product.price.toStringAsFixed(2)}',
                            image: widget.image,
                            quantity: quantity,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                buyNowItem: buyNowItem,
                              ),
                            ),
                          );
                        },
                  icon: const Icon(Icons.flash_on),
                  label: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductInfo(
              name: product.name,
              price:
                  '₦${product.price.toStringAsFixed(2)}',
              rating: widget.rating,
            ),

            const SizedBox(height: 20),

            ProductGallery(
              image: widget.image,
              heroTag: product.id,
            ),

            const SizedBox(height: 25),

            const SellerCard(),

            const SizedBox(height: 24),

            const ProductDeliveryCard(),

            const SizedBox(height: 24),

            const ProductSpecifications(),

            const SizedBox(height: 24),

            const ProductReviews(),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Category: ${product.category}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Available Stock: ${product.stockQuantity}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Quantity',
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
                  icon: const Icon(
                    Icons.remove_circle,
                    size: 30,
                  ),
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
                    if (quantity < product.stockQuantity) {
                      setState(() {
                        quantity++;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            const SizedBox(height: 28),

const Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: Text(
    'Related Products',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 16),

Consumer<ProductManager>(
  builder: (context, productManager, child) {
    final relatedProducts = productManager.products
        .where(
          (item) =>
              item.id != product.id &&
              item.category == product.category,
        )
        .toList();

    if (relatedProducts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Text(
          'No related products available.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return SizedBox(
      height: 380,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        itemCount: relatedProducts.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final relatedProduct = relatedProducts[index];

          return SizedBox(
            width: 190,
            child: ProductCard(
              product: relatedProduct,
              image: _imageForCategory(
                relatedProduct.category,
              ),
              rating: 4.8,
            ),
          );
        },
      ),
    );
  },
),

const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}