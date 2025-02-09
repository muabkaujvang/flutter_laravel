// import 'package:flutter/material.dart';

// class ProductDetailsPage extends StatelessWidget {
//   final String productName;
//   final String productImage;
//   final double productPrice;

//   const ProductDetailsPage({
//     super.key,
//     required this.productName,
//     required this.productImage,
//     required this.productPrice,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(productName),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage('https://via.placeholder.com/150?text=Mechanical+Keyboard'),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               productName,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '\$${productPrice.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.orange,
//               ),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle adding the product to the cart
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('$productName added to your cart!'),
//                   ),
//                 );
//               },
//               child: const Text('Add to Cart'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
