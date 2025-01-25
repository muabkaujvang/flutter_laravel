import 'package:flutter/material.dart';
import 'package:frontend_laravel/components/drawer.dart';

class ExpenditurePage extends StatefulWidget {
  const ExpenditurePage({super.key});

  @override
  State<ExpenditurePage> createState() => _ExpenditurePageState();
}

class _ExpenditurePageState extends State<ExpenditurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('expenditure'),
        backgroundColor: Colors.blue,
      ),
      drawer: AppDrawer(),
    );
  }
}