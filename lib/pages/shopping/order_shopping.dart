import 'package:flutter/material.dart';
import 'package:frontend_laravel/components/bag_item.dart';
import 'package:frontend_laravel/model/cartItem_model.dart';
import 'package:frontend_laravel/pages/shopping/check_out.dart';

class OrderShopping extends StatefulWidget {
  final List<CartItem> cartItems;

  const OrderShopping({super.key, required this.cartItems});

  @override
  State<OrderShopping> createState() => _OrderShoppingState();
}

class _OrderShoppingState extends State<OrderShopping> {
  double _calculateTotal() {
    return widget.cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _increaseQuantity(int index) {
    setState(() {
      widget.cartItems[index].quantity += 1;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index].quantity -= 1;
      }
    });
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this item from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.cartItems.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                widget.cartItems.clear();
              });
            },
          ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return BagItem(
                        itemName: item.title,
                        itemPrice: item.price.toDouble(),
                        itemQuantity: item.quantity,
                        itemImage: item.imageUrl,
                        onIncrease: () => _increaseQuantity(index),
                        onDecrease: () => _decreaseQuantity(index),
                        onDelete: () => _deleteItem(index),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: ₭${_calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            cartItems: widget.cartItems,
                            clearCart: () {
                              setState(() {
                                widget.cartItems.clear();
                              });
                            },
                            saveOrder: ( orders) {
                              print("Order saved: $orders");
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}
