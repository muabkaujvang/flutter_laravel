import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_laravel/api_path.dart';
import 'package:frontend_laravel/pages/shopping/order_history.dart';
import 'package:frontend_laravel/model/cartItem_model.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(List<Map<String, dynamic>>) saveOrder;
  final Function() clearCart;

  const CheckoutPage({
    Key? key,
    required this.cartItems,
    required this.saveOrder,
    required this.clearCart,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool isSaving = false;

  // Calculate the total price of the cart
  double _calculateTotal() {
    return widget.cartItems.fold(
      0,
      (sum, item) {
        final price = item.price ?? 0;
        final quantity = item.quantity ?? 0;
        return sum + (price * quantity);
      },
    );
  }

  // Submit the order
  _submitOrder() async {
    
    try {
      setState(() {
        isSaving = true;
      });
      var userId = await storage.read(key: 'userId');
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(ApiPath.saveOrder));
      request.body = json.encode({
        "user_id": userId ?? '1',
        "total_amount": _calculateTotal(),
        "province": _provinceController.text,
        "district": _districtController.text,
        "village": _villageController.text,
        "order_date":
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        "status": "pending"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        //print(await response.stream.bytesToString());
        var data = await response.stream.bytesToString();
        var jsonData = jsonDecode(data);
        var id = jsonData['id'];
        log('data=${id}');
        saveOrderDetail(orderId: id.toString());
        await Future.delayed(const Duration(seconds: 2));
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order submitted successfully!')),
        );
        setState(() {
          isSaving = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OrderHistoryPage(),
          ),
          (route) => route.isFirst, // Keep only the first route (ShoppingPage)
        );
      } else {
        print(response.reasonPhrase);
        setState(() {
          isSaving = false;
        });
      }
    } catch (e) {
      log('Error =$e ');
      setState(() {
        isSaving = false;
      });
    }

  }

  saveOrderDetail({required String orderId}) async {
    try {
      for (var element in widget.cartItems) {
        var headers = {'Content-Type': 'application/json'};
        var request = http.Request('POST', Uri.parse(ApiPath.saveOrderDetail));
        request.body = json.encode({
          "order_id": orderId,
          "product_id": element.id,
          "quantity": element.quantity,
          "price": element.price,
        });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 201) {
          print(await response.stream.bytesToString());
        } else {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {}
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _provinceController.text = "provicne111";
  //   _districtController.text = "destrict11";
  //   _villageController.text = "village11";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display cart items with quantity
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Image.network(
                        item.imageUrl ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('₭${item.price} x ${item.quantity}'),
                          Text(
                            'Subtotal: ₭${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  item.quantity -= 1;
                                }
                              });
                            },
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item.quantity += 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Address Input Fields
            TextField(
              controller: _provinceController,
              decoration: const InputDecoration(labelText: "Province"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _districtController,
              decoration: const InputDecoration(labelText: "District"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _villageController,
              decoration: const InputDecoration(labelText: "Village"),
            ),
            const SizedBox(height: 20),
            // Display Total Order Amount
            Text(
              'Total Order Amount: ₭${_calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Confirm Order Button
            ElevatedButton(
              onPressed: isSaving ? null : _submitOrder,
              child: isSaving
                  ? const CircularProgressIndicator()
                  : const Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}
