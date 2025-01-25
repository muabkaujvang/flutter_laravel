import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_laravel/components/filter_button.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  FilterButton(label: 'T-shirts'),
                  SizedBox(width: 8),
                  FilterButton(label: 'Crop tops'),
                  SizedBox(width: 8),
                  FilterButton(label: 'Pants'),
                  SizedBox(width: 8),
                  FilterButton(label: 'Shoes'),
                  SizedBox(width: 8),
                  FilterButton(label: 'Accessories'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ElevatedButton.icon(
          //         icon: Icon(Icons.filter_list),
          //         label: Text('Filters'),
          //         onPressed: () {},
          //       ),
          //       DropdownButton<String>(
          //         value: 'price: lowest to high',
          //         items: const [
          //           DropdownMenuItem(
          //             child: Text('price: highest to low'),
          //             value: 'Price: highest to low',
          //           ),
          //           DropdownMenuItem(
          //             child: Text('price: lowest to high'),
          //             value: 'Price: lowest to high',
          //           ),
          //         ],
          //         onChanged: (value) {},
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => Container(),
            ),
          ),
        ],
      ),
    );
  }
}
