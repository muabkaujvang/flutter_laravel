class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  // Convert CartItem to Map (useful for storing in local storage or database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  // Create a CartItem from a Map (useful when retrieving from storage or API)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 1,
    );
  }
}