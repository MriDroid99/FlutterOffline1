import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/widget/drawer.dart';
import 'package:shopapp/widget/manage_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> _prods = Provider.of<Products>(context).prods;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Products'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const DrawerItem(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _prods.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value: _prods[i],
            child: const ManageProductItem(),
          ),
        ),
      ),
    );
  }
}
