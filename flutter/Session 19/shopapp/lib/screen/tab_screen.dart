import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/screen/favorites_screen.dart';
import 'package:shopapp/screen/products_screen.dart';
import 'package:shopapp/widget/badge.dart';
import 'package:shopapp/widget/drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool _isFirst = true;
  late List<Map<String, dynamic>> _pages;
  int _currentIndex = 0;
  // bool _isLoading = true;

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
    // Provider.of<Products>(context, listen: false).fetchData().then((value) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isFirst) {
      Provider.of<CartItems>(context, listen: false).getItems();
      _isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
        actions: [
          Badge(
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            value: Provider.of<CartItems>(context).itemsCount.toString(),
          ),
        ],
      ),
      drawer: const DrawerItem(),
      body: FutureBuilder(
          future: Provider.of<Products>(context, listen: false).fetchData(),
          builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return _pages[_currentIndex]['body'];
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
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
