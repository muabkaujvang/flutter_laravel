import 'package:flutter/material.dart';
import 'package:frontend_laravel/pages/shopping/order_history.dart';
import 'package:frontend_laravel/pages/shopping/order_shopping.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Image(
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/019/787/015/non_2x/shopping-cart-icon-shopping-basket-on-transparent-background-free-png.png'),
                      width: 60,
                      height: 60,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "E-Shop",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 50),
                  Padding(
                    padding: EdgeInsets.only(left: 150, top: 15),
                    child: IconButton(
                      icon: Icon(Icons.card_travel),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderShopping(cartItems: [],),
                          ),
                        );
                      },
                    ),
                  ),
                  //  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderShopping(cartItems: [],),
                          ),
                        );
                      },
                    ),
                  ),
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
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'search...'),
              ),
            ),
            SizedBox(height: 10),
            // Address
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.orange),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Deliver to: Jl. Rose No. 123 Block A, Cipete Sub-District',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Categories
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final categories = [
                  'Keyboard',
                  'Mouse',
                  'CPU',
                  'RAM',
                  'Monitors',
                  'Speakers',
                  'Headphones',
                  'Laptops'
                ];
                return Column(
                  children: [
                    CircleAvatar(radius: 30, child: Icon(Icons.abc_outlined)),
                    SizedBox(height: 5),
                    Text(
                      categories[index],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            // Flash Sale Banner
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://5.imimg.com/data5/ANDROID/Default/2020/10/OS/ZJ/BE/3789916/computer-accessories-1510742884-3454015-jpeg-500x500.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  '6.6 Flash Sale\nCashback Up to 100%',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Flash Sale', style: TextStyle(fontSize: 16)),
                  Text('See all', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Add this line
                      children: [
                        // Product Image
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfUN4CexOBqfnW-4Lfjr9CP3KAAHSy79mk_w&s',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        // Product Name
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Product Name',
                            style: TextStyle(fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Product Price
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$100',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        // Add to Cart Button at the bottom
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement cart functionality here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Product added to your cart!'),
                                ),
                              );
                            },
                            child: Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity,
                                  40), // Ensure the button is stretched
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
