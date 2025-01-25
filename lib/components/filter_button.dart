
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: OutlinedButton(
        child: Text(
          '$label',
        ),
        onPressed: (){},
      ),
    );
  }
}