// import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:shopapp/util/constants.dart';

class Product with ChangeNotifier {
  String id, title, description, imgUrl;
  double price;
  bool isFav;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.price,
    this.isFav = false,
  });

  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  String? uid;
  String? token;
  // ignore: prefer_final_fields
  List<Product> _prods;

  Products({this.uid, this.token, List<Product>? prods}) : _prods = prods ?? [];
  //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',

  List<Product> get prods => [..._prods];

  List<Product> get fevProd =>
      _prods.where((element) => element.isFav).toList();

  Product findById(String id) =>
      _prods.firstWhere((element) => element.id == id);

  Future<void> fetchData() async {
    // var response =
    //     await get(Uri.parse('$mainURL/products/$_uid.json?auth=$_token'));
    final dbRef = await FirebaseDatabase.instance
        .reference()
        .child('products')
        .child(uid!)
        .get();

    var extractedData = dbRef.value;

    _prods.clear();
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((id, data) {
      _prods.add(
        Product(
          id: id,
          title: data['title'],
          description: data['description'],
          imgUrl: data['imgUrl'],
          price: double.parse(data['price'].toString()),
        ),
      );
    });
    // notifyListeners();
  }

  Future<void> addProduct(
    String id,
    String title,
    double price,
    String description,
    String imgUrl,
  ) async {
    // var response = await post(
    //   Uri.parse('$mainURL/products/$_uid.json?auth=$_token'),
    // body: json.encode({
    //   'title': title,
    //   'description': description,
    //   'imgUrl': imgUrl,
    //   'price': price,
    // }),
    // );

    final dbRef = FirebaseDatabase.instance
        .reference()
        .child('products')
        .child(uid!)
        .push();

    await dbRef.set({
      'title': title,
      'description': description,
      'imgUrl': imgUrl,
      'price': price,
    });

    _prods.add(Product(
      id: dbRef.key,
      title: title,
      description: description,
      imgUrl: imgUrl,
      price: price,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(
    String id,
    String title,
    double price,
    String description,
    String imgUrl,
  ) async {
    // await patch(
    //   Uri.parse('$mainURL/products/$_uid/$id.json?auth=$_token'),
    //   body: json.encode({
    //     'title': title,
    //     'description': description,
    //     'imgUrl': imgUrl,
    //     'price': price,
    //   }),
    // );

    await FirebaseDatabase.instance
        .reference()
        .child('products')
        .child(uid!)
        .child(id)
        .update({
      'title': title,
      'description': description,
      'imgUrl': imgUrl,
      'price': price,
    });

    int updatedIndex = _prods.indexWhere((element) => element.id == id);
    _prods[updatedIndex] = Product(
      id: id,
      title: title,
      description: description,
      imgUrl: imgUrl,
      price: price,
    );
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    // await delete(Uri.parse('$mainURL/products/$_uid/$id.json?auth=$_token'));
    await FirebaseDatabase.instance
        .reference()
        .child('products')
        .child(uid!)
        .child(id)
        .remove();
    _prods.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void toggleFav(String id) {
    _prods.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }
}
