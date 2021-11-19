import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/cart.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItem _item = Provider.of(context);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(_item.title),
          subtitle: Text('${_item.price * _item.quantity}'),
          trailing: Text('${_item.price}x${_item.quantity}'),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          closeOnTap: false,
          caption: 'Add',
          color: Colors.blue,
          icon: Icons.add,
          onTap: () => Provider.of<CartItems>(context, listen: false)
              .increaseQuantity(_item.id),
        ),
        IconSlideAction(
          caption: 'Remove',
          color: Colors.indigo,
          icon: Icons.remove,
          onTap: () => Provider.of<CartItems>(context, listen: false)
              .decreaseQuantity(_item.id),
        ),
      ],
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => Provider.of<CartItems>(context, listen: false)
              .removeItem(_item.id),
        ),
      ],
    );
  }
}
