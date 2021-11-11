import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopapp/util/constants.dart';

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
  final List<Product> _prods = [
    // Product(
    //   id: '1',
    //   title: 'title1',
    //   description: 'description1',
    //   imgUrl:
    //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',
    //   price: 100,
    // ),
    // Product(
    //   id: '2',
    //   title: 'title2',
    //   description: 'description2',
    //   imgUrl:
    //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',
    //   price: 100,
    // ),
    // Product(
    //   id: '3',
    //   title: 'title3',
    //   description: 'description3',
    //   imgUrl:
    //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',
    //   price: 100,
    // ),
    // Product(
    //   id: '4',
    //   title: 'title4',
    //   description: 'description4',
    //   imgUrl:
    //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',
    //   price: 100,
    // ),
    // Product(
    //   id: '5',
    //   title: 'title5',
    //   description: 'description5',
    //   imgUrl:
    //       'https://th.bing.com/th/id/OIP.UuHyPx-mK3IxCdHBFgXJVwHaEK?pid=ImgDet&rs=1',
    //   price: 100,
    // ),
  ];

  List<Product> get prods => [..._prods];

  List<Product> get fevProd =>
      _prods.where((element) => element.isFav).toList();

  Product findById(String id) =>
      _prods.firstWhere((element) => element.id == id);

  Future<void> fetchData() async {
    var response = await get(Uri.parse('$mainURL/products.json'));
    Map<String, dynamic>? extractedData =
        json.decode(response.body) as Map<String, dynamic>?;

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
          price: data['price'],
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
    var response = await post(
      prodURL,
      body: json.encode({
        'title': title,
        'description': description,
        'imgUrl': imgUrl,
        'price': price,
      }),
    );

    _prods.add(Product(
      id: json.decode(response.body)['name'],
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
    await patch(
      Uri.parse('$mainURL/products/$id.json'),
      body: json.encode({
        'title': title,
        'description': description,
        'imgUrl': imgUrl,
        'price': price,
      }),
    );

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
    await delete(Uri.parse('$mainURL/products/$id.json'));
    // _prods.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void toggleFav(String id) {
    _prods.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }
}
