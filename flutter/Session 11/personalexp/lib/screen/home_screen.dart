import 'package:flutter/material.dart';
import 'package:personalexp/model/item.dart';
import 'package:personalexp/widget/item_widget.dart';
import 'package:personalexp/widget/sheet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _item = [];

  void addItem(String id, String title, double price, DateTime date) {
    setState(() {
      _item.add(Item(
        id: id,
        title: title,
        price: price,
        date: date,
      ));
    });
  }

  void removeItem(String id) {
    setState(() {
      _item.removeWhere((element) => element.id == id);
    });
  }

  void _showSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SheetWidget(addItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expanses'),
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => ItemWidget(
          _item[i].id,
          _item[i].title,
          _item[i].price,
          _item[i].date,
          removeItem,
        ),
        separatorBuilder: (_, i) => const Divider(
          thickness: 1.5,
          height: 0,
        ),
        itemCount: _item.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
