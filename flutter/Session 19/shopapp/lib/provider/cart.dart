import 'package:flutter/material.dart';

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
  final Map<String, CartItem> _items = {};

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

  void addItem(String id, String title, double price, int quantity) {
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

  void increaseQuantity(String id) {
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

  void decreaseQuantity(String id) {
    if (_items[id]!.quantity == 1) {
      return;
    }
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

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
