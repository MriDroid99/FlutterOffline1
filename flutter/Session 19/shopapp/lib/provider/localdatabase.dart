import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase with ChangeNotifier {
  Database? dbRef;

  Future<void> createDB() async {
    dbRef = await openDatabase(
      'shop.db',
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute(
            'CREATE TABLE cart (id TEXT PRIMARY KEY, title TEXT, price REAL, quantity INTEGER)');
      },
    );
    // notifyListeners();
  }
}
