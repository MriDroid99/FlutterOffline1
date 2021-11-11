import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/order.dart';
import 'package:shopapp/widget/drawer.dart';
import 'package:shopapp/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const DrawerItem(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Order> _orders = Provider.of<Orders>(context).orders;
            return ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: _orders[i],
                child: const OrderItem(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
