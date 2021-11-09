import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/order.dart';
import 'package:shopapp/widget/drawer.dart';
import 'package:shopapp/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> _orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const DrawerItem(),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
          value: _orders[i],
          child: const OrderItem(),
        ),
      ),
    );
  }
}
