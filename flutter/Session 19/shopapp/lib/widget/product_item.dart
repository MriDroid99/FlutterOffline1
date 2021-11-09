import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/provider/product.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    Product _prod = Provider.of(context);
    bool _isCartItem = Provider.of<CartItems>(context).isCartItem(_prod.id);
    return GridTile(
      child: Image.network(_prod.imgUrl),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Center(child: Text(_prod.title)),
        leading: IconButton(
          onPressed: () =>
              Provider.of<Products>(context, listen: false).toggleFav(_prod.id),
          icon: Icon(
            _prod.isFav ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Provider.of<CartItems>(context, listen: false)
                .addItem(_prod.id, _prod.title, _prod.price, 1);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(_isCartItem
                    ? '${_prod.title} already in cart'
                    : '${_prod.title} added to cart'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () =>
                      Provider.of<CartItems>(context, listen: false)
                          .removeItem(_prod.id),
                ),
              ),
            );
          },
          icon: Icon(
            _isCartItem
                ? Icons.remove_shopping_cart_outlined
                : Icons.add_shopping_cart_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
