import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          onPressed: () {},
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
