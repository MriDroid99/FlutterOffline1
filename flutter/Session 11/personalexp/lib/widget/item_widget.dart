import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexp/model/item.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Item _item = Provider.of(context);
    return ListTile(
      title: Text(_item.title),
      subtitle: Text(DateFormat.yMMMd().format(_item.date)),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        radius: 25,
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${_item.price}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        )),
      ),
      trailing: IconButton(
        onPressed: () {
          Provider.of<Items>(context, listen: false).removeItem(_item.id);
        },
        icon: const Icon(Icons.delete_outlined),
        color: Colors.red,
      ),
    );
  }
}
