import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend_laravel/pages/expenditure_page.dart';
import 'package:frontend_laravel/pages/home_page.dart';
import 'package:frontend_laravel/pages/profile_page.dart';
import 'package:frontend_laravel/pages/shopping_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _page = [
    HomePage(),
    ShoppingPage(),
    ExpenditurePage(),
    ProfilePage()
  ];

  final List<Widget> _navigationItems = [
    Icon(Icons.home),
    Icon(Icons.shopping_cart),
    Icon(Icons.exit_to_app),
    Icon(Icons.person)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: _navigationItems,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
