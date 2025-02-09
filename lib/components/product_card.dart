import 'package:flutter/material.dart';
import 'package:frontend_laravel/model/cartItem_model.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final double? productOriginalPrice;
  final String
      description; // ✅ FIXED: Changed from "decoration" to "description"
  final double rating;
  final int reviewCount;
  final Function(CartItem) onAddToCart;

  const ProductCard({
    Key? key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.productOriginalPrice,
    required this.description, // ✅ FIXED: Changed from "decoration" to "description"
    required this.rating,
    required this.reviewCount,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Image.network(
                productImage.isNotEmpty ? productImage : '',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Image(
                    image: AssetImage(
                        'assets/images/placeholder.png'), // ✅ FIXED: Use a local placeholder
                    height: 100,
                    width: double.infinity,
                  );
                },
              ),
              // Product Info
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Price Info
                    Row(
                      children: [
                        Text(
                          '₭${productPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (productOriginalPrice != null &&
                            productOriginalPrice! > 0)
                          Text(
                            '₭${productOriginalPrice!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    // Rating Info
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                        Text(
                          '$rating ($reviewCount reviews)',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description, // ✅ FIXED: Changed from "decoration" to "description"
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // final item = {
                    //   'imageUrl': productImage,
                    //   'title': productName,
                    //   'price': productPrice,
                    //   'quantity': 1,
                    // };
                    var item = CartItem(
                      id: productId.toString(),
                      title: productName,
                      imageUrl: productImage,
                      price: productPrice,
                      quantity: 1,
                    );
                    onAddToCart(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('$productName added to your cart!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
