import 'package:flutter/material.dart';
import 'package:shopping_app/screens/catalog/catalog.dart';
import 'package:shopping_app/screens/checkout/checkout.dart';
import 'package:shopping_app/screens/favorites/favorites.dart';
import 'package:shopping_app/screens/home/home.dart';
import 'package:shopping_app/widgets/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const <Widget>[
    Home(),
    Catalog(),
    Favorites(),
    Checkout(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
    );
  }
}