import 'package:flutter/material.dart';
import 'package:shopapp/screen/favorites_screen.dart';
import 'package:shopapp/screen/products_screen.dart';
import 'package:shopapp/widget/drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int _currentIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'title': 'My Products',
        'body': const ProductsScreen(),
      },
      {
        'title': 'Favorites',
        'body': const FavoritesScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
      ),
      drawer: const DrawerItem(),
      body: _pages[_currentIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorites')
        ],
      ),
    );
  }
}
