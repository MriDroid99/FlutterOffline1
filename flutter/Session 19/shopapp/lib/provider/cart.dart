import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CartItem with ChangeNotifier {
  String id, title;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}

class CartItems with ChangeNotifier {
  CartItems({this.dbRef, Map<String, CartItem>? items}) : _items = items ?? {};

  Database? dbRef;

  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemsCount => _items.length;

  bool isCartItem(String id) => _items.containsKey(id);

  void clearCart() => _items.clear();

  double get totalPrice {
    double total = 0;
    _items.forEach(
      (key, value) {
        total += value.price * value.quantity;
      },
    );
    return total;
  }

  Future<void> getItems() async {
    List<Map> prods = await dbRef!.rawQuery('SELECT * FROM cart');
    print(prods);
    for (var element in prods) {
      _items.addAll({
        element['id']: CartItem(
          id: element['id'],
          title: element['title'],
          price: element['price'],
          quantity: element['quantity'],
        ),
      });
    }
    notifyListeners();
  }

  Future<void> addItem(
      String id, String title, double price, int quantity) async {
    await dbRef!.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO cart(id, title, price, quantity) VALUES(?, ?, ?, ?)',
        [id, title, price, quantity],
      );
    });
    _items.addAll(
      {
        id: CartItem(
          id: id,
          title: title,
          price: price,
          quantity: quantity,
        ),
      },
    );
    notifyListeners();
  }

  Future<void> increaseQuantity(String id) async {
    List<Map> prods =
        await dbRef!.rawQuery('SELECT * FROM cart where id = ?', [id]);
    await dbRef!.rawUpdate('UPDATE cart SET quantity = ? WHERE id = ?',
        [prods[0]['quantity'] + 1, id]);
    _items.update(
      id,
      (oldItem) => CartItem(
        id: id,
        title: oldItem.title,
        price: oldItem.price,
        quantity: oldItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  Future<void> decreaseQuantity(String id) async {
    if (_items[id]!.quantity == 1) {
      return;
    }
    List<Map> prods =
        await dbRef!.rawQuery('SELECT * FROM cart where id = ?', [id]);
    await dbRef!.rawUpdate('UPDATE cart SET quantity = ? WHERE id = ?',
        [prods[0]['quantity'] - 1, id]);
    _items.update(
      id,
      (oldItem) => CartItem(
        id: id,
        title: oldItem.title,
        price: oldItem.price,
        quantity: oldItem.quantity - 1,
      ),
    );
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    await dbRef!.rawDelete('DELETE FROM cart WHERE id = ?', [id]);
    _items.remove(id);
    notifyListeners();
  }
}
