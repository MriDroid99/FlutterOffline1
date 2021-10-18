import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  String id, title;
  double price;
  DateTime date;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.date,
  });
}

class Items with ChangeNotifier {
  final List<Item> _items = [
    Item(
      id: '1',
      title: 'title1',
      price: 150,
      date: DateTime.now(),
    ),
  ];

  List<Item> get items => [..._items];

  void addItem(String id, String title, double price, DateTime date) {
    _items.add(Item(
      id: id,
      title: title,
      price: price,
      date: date,
    ));

    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
