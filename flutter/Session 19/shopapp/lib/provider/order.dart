// import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:shopapp/provider/cart.dart';
// import 'package:shopapp/util/constants.dart';

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
  String? uid;
  String? token;
  // ignore: prefer_final_fields
  List<Order> _orders;

  Orders({this.uid, this.token, List<Order>? orders}) : _orders = orders ?? [];

  List<Order> get orders => [..._orders];

  Future<void> fetchData() async {
    // var response =
    //     await get(Uri.parse('$mainURL/orders/$_uid.json?auth=$_token'));
    final dbRef =
        await FirebaseDatabase.instance.reference().child('orders').get();
    // Map<String, dynamic>? extractedData =
    //     json.decode(response.body) as Map<String, dynamic>?;

    var extractedData = dbRef.value;

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
                  price: double.parse(e['price'].toString()),
                  quantity: e['quantity'],
                ),
              )
              .toList(),
          totalPrice: double.parse(data['totalPrice'].toString()),
          date: DateTime.parse(data['date']),
        ),
      );
    });
    // notifyListeners();
  }

  Future<void> addOrder(
      String id, List<CartItem> prods, double totalPrice, DateTime date) async {
    // await post(
    //   Uri.parse('$mainURL/orders/$_uid.json?auth=$_token'),
    //   body: json.encode({
    //     'prods': prods
    //         .map((e) => {
    //               'id': e.id,
    //               'title': e.title,
    //               'price': e.price,
    //               'quantity': e.quantity,
    //             })
    //         .toList(),
    //     'totalPrice': totalPrice,
    //     'date': date.toIso8601String(),
    //   }),
    // );
    final dbRef = FirebaseDatabase.instance.reference().child('orders').push();
    await dbRef.set({
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
    });
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
