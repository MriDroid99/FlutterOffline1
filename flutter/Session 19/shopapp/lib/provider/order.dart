import 'package:flutter/material.dart';
import 'package:shopapp/provider/cart.dart';

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

  void addOrder(
      String id, List<CartItem> prods, double totalPrice, DateTime date) {
    _orders.add(
      Order(
        id: id,
        prods: prods,
        totalPrice: totalPrice,
        date: date,
      ),
    );
    notifyListeners();
  }
}
