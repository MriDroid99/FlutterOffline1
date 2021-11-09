import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/provider/order.dart';
import 'package:shopapp/widget/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, CartItem> _items = Provider.of<CartItems>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: _items.values.toList()[i],
                child: const CartWidget(),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text(
                      '${Provider.of<CartItems>(context, listen: false).totalPrice}')
                ],
              ),
            ),
          ),
          if (_items.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                Provider.of<Orders>(context, listen: false).addOrder(
                  DateTime.now().toIso8601String(),
                  _items.values.toList(),
                  Provider.of<CartItems>(context, listen: false).totalPrice,
                  DateTime.now(),
                );
                Provider.of<CartItems>(context, listen: false).clearCart();
                Navigator.pushReplacementNamed(context, '/order');
              },
              child: const Text('Order'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
              ),
            )
        ],
      ),
    );
  }
}
