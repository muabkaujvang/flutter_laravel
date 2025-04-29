import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_laravel/api_path.dart';
import 'package:frontend_laravel/model/order_model.dart';
import 'package:frontend_laravel/pages/shopping_page.dart';
import 'package:frontend_laravel/screens/dashboard_screen.dart'; // Import ShoppingPage
import 'package:http/http.dart' as http;

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<OrderModel> orderList = [];
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    setState(() {
      isLoading = true;
    });

    var userId = await storage.read(key: 'userId') ?? '';
    if (userId.isEmpty) {
      print('Error: User ID is missing');
      setState(() {
        isLoading = false;
      });
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
    };
    var request =
        http.Request('GET', Uri.parse('${ApiPath.orderHistory}$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      setState(() {
        orderList = orderModelFromJson(data);
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: Builder(builder: (context) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (orderList.isEmpty) {
          return const Center(child: Text("No past orders found"));
        }
        return ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            final order = orderList[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ExpansionTile(
                title: Text("Order ID: ${order.id}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Province: ${order.province}"),
                    Text("District: ${order.district}"),
                    Text("Village: ${order.village}"),
                    Text("Total: ₭${order.totalAmount}"),
                    order.status.toString() == "pending"
                        ? RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Status: ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const TextSpan(
                                  text: 'ລໍຖ້າອະນຸມັດ',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Status: ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const TextSpan(
                                  text: 'ອະນຸມັດແລ້ວ',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Items:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (order.orderDetails == null ||
                            order.orderDetails!.isEmpty)
                          const Text("No items found")
                        else
                          ...order.orderDetails!.map<Widget>((item) {
                            double price =
                                double.tryParse(item.product!.price!) ?? 0;
                            return ListTile(
                              leading: Image.network(
                                ApiPath.BASE_IMAGE + item.product!.imageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item.product!.name!),
                              subtitle: Text('₭$price'),
                              trailing: Text(
                                'Subtotal: ${item.quantity} x ₭$price = ₭ ${(price * item.quantity!).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                  // Buy Again Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Buy Again logic (Navigate to ShoppingPage)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShoppingPage(),
                          ),
                        );
                      },
                      child: const Text("Buy Again"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
