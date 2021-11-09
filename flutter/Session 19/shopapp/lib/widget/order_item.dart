import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Order _order = Provider.of(context);
    return ExpansionTile(
      title: Text('${_order.totalPrice}'),
      subtitle: Text(DateFormat.yMMMd().format(_order.date)),
      children: _order.prods
          .map(
            (e) => ListTile(
              title: Text(e.title),
              trailing: Text('${e.price}x${e.quantity}'),
            ),
          )
          .toList(),
    );
  }
}
