import 'package:flutter/material.dart';
import 'package:frontend_laravel/components/fullImageViewer.dart';

class BagItem extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final int itemQuantity;
  final String itemImage; // Add image field
  final VoidCallback? onIncrease;  // Make optional
  final VoidCallback? onDecrease;  // Make optional
  final VoidCallback? onDelete;    // Make optional

  const BagItem({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
    required this.itemImage, // Accept image as a parameter
    this.onIncrease,
    this.onDecrease,
    this.onDelete, // Initialize delete callback as optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            // Open full-screen image viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageViewer(imageUrl: itemImage),
              ),
            );
          },
          child: Image.network(
            itemImage.isNotEmpty
                ? itemImage
                : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEMxMO4WXhpVDBzU_bpTgF_8mb1md8uk03dg&s', // Fallback image
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image, size: 50); // Icon if image fails
            },
          ),
        ),
        title: Text(itemName),
        subtitle: Text('₭${itemPrice.toStringAsFixed(2)} x $itemQuantity'),
        trailing: onIncrease != null || onDecrease != null || onDelete != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onDecrease != null)
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onDecrease,
                    ),
                  if (onIncrease != null)
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onIncrease,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
