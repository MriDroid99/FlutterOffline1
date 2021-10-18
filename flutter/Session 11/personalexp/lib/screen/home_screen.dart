import 'package:flutter/material.dart';
import 'package:personalexp/model/item.dart';
import 'package:personalexp/widget/item_widget.dart';
import 'package:personalexp/widget/sheet_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Item> _items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expanses'),
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
          value: _items[i],
          child: const ItemWidget(),
        ),
        separatorBuilder: (_, i) => const Divider(
          thickness: 1.5,
          height: 0,
        ),
        itemCount: _items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
