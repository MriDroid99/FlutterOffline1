import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';

class ManageProductItem extends StatelessWidget {
  const ManageProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product _prod = Provider.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_prod.imgUrl),
        radius: 25,
      ),
      title: Text(_prod.title),
      subtitle: Text('${_prod.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/add', arguments: _prod.id),
            icon: const Icon(Icons.edit),
          ),
          const VerticalDivider(
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
          ),
          IconButton(
            onPressed: () => Provider.of<Products>(context, listen: false)
                .removeProduct(_prod.id),
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
