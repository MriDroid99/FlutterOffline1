import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemWidget extends StatelessWidget {
  final String id, title;
  final double price;
  final DateTime date;
  final Function(String id) removeItem;
  const ItemWidget(this.id, this.title, this.price, this.date, this.removeItem,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(DateFormat.yMMMd().format(date)),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        radius: 25,
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$price',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        )),
      ),
      trailing: IconButton(
        onPressed: () {
          removeItem(id);
        },
        icon: const Icon(Icons.delete_outlined),
        color: Colors.red,
      ),
    );
  }
}
