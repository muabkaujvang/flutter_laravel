import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend_laravel/api_path.dart';
import 'package:frontend_laravel/components/product_card.dart';
import 'package:frontend_laravel/model/cartItem_model.dart';
import 'package:frontend_laravel/model/product_model.dart';
import 'package:frontend_laravel/pages/shopping/order_history.dart';
import 'package:frontend_laravel/pages/shopping/order_shopping.dart';
import 'package:http/http.dart' as http;

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  String selectedCategory = 'Keyboards';
  List products = [];
  bool isLoading = true;

  // Dynamically populated categories
  final List<String> categories = [
    'Keyboards',
    'Mouse',
    'Monitors',
    'Speakers',
    'Headphones',
    'Laptops',
    'Tablets',
    'Accessories'
  ];

  // Mock product data for multiple categories
  final Map<String, List<Map<String, dynamic>>> mockProducts = {};

  List<CartItem> cartItems = [];
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts(selectedCategory);
  }

  Future<void> fetchProducts(String category) async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': '',
    };
    var request = http.Request('GET', Uri.parse(ApiPath.getProduct));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      var data = await response.stream.bytesToString();

      setState(() {
        productList = productModelFromJson(data);
      });
      log('in susseccss = $productList ');
    } else {
      print(response.reasonPhrase);
      log('in errpr');
    }

    setState(() {
      products = mockProducts[category] ?? [];
      isLoading = false;
    });
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    fetchProducts(category);
  }

  void onAddToCart(CartItem product) {
    // var item = CartItem(
    //     id: product.id.toString(),
    //     title: product.name.toString(),
    //     imageUrl: product.imageUrl.toString(),
    //     price: double.parse(product.price!),
    //     quantity: 1,);
    setState(() {
      cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Custom Header
          Container(
            child: Row(
              children: [
                // E-Shop Logo
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Image(
                    image: const NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/019/787/015/non_2x/shopping-cart-icon-shopping-basket-on-transparent-background-free-png.png',
                    ),
                    width: 60,
                    height: 60,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: const Text(
                    "E-Shop",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(), // Pushes everything to the right

                // Shopping Cart Icon
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderShopping(
                            cartItems: cartItems,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // More Options Menu
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "history") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderHistoryPage(
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "history",
                        child: Text("Order History"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Category Buttons - Horizontal Scroll
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () => onCategorySelected(category),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == category
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                      child: Text(category),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Body Content
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : productList.isEmpty
                    ? const Center(child: Text('No products found.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          final product = productList[index];
                          var item = CartItem(
                            id: product.id.toString(),
                            title: product.name.toString(),
                            imageUrl: product.imageUrl.toString(),
                            price: double.parse(product.price!),
                            quantity: 1,
                          );
                          return ProductCard(
                            productId: product.id!,
                            productName: product.name.toString(),
                            productImage:
                                ApiPath.BASE_IMAGE + (product.imageUrl ?? ""),
                            productPrice: double.tryParse(
                                    product.price?.toString() ?? "0") ??
                                0,
                            productOriginalPrice: double.tryParse(
                                product.originalPrice?.toString() ?? "0"),
                            description: product.description ?? "",
                            rating: double.tryParse(
                                    product.rating?.toString() ?? "0") ??
                                0,
                            reviewCount: int.tryParse(
                                    product.reviewCount?.toString() ?? "0") ??
                                0,
                            onAddToCart: onAddToCart,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
