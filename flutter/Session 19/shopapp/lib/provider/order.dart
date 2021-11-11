import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/util/constants.dart';

class Order with ChangeNotifier {
  String id;
  List<CartItem> prods;
  DateTime date;
  double totalPrice;

  Order({
    required this.id,
    required this.prods,
    required this.totalPrice,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> fetchData() async {
    var response = await get(Uri.parse('$mainURL/orders.json'));
    Map<String, dynamic>? extractedData =
        json.decode(response.body) as Map<String, dynamic>?;

    _orders.clear();
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((id, data) {
      _orders.add(
        Order(
          id: id,
          prods: (data['prods'] as List<dynamic>)
              .map(
                (e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  price: e['price'],
                ),
              )
              .toList(),
          totalPrice: data['totalPrice'],
          date: DateTime.parse(data['date']),
        ),
      );
    });
    // notifyListeners();
  }

  Future<void> addOrder(
      String id, List<CartItem> prods, double totalPrice, DateTime date) async {
    var response = await post(
      Uri.parse('$mainURL/orders.json'),
      body: json.encode({
        'prods': prods
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'price': e.price,
                  'quantity': e.quantity,
                })
            .toList(),
        'totalPrice': totalPrice,
        'date': date.toIso8601String(),
      }),
    );
    // _orders.add(
    //   Order(
    //     id: json.decode(response.body)['name'],
    //     prods: prods,
    //     totalPrice: totalPrice,
    //     date: date,
    //   ),
    // );
    notifyListeners();
  }
}
