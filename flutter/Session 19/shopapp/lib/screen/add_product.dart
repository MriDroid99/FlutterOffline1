import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late GlobalKey<FormState> _formKey;
  // Product prod =
  //     Product(id: '', title: '', description: '', imgUrl: '', price: 0);
  Map<String, dynamic> prod = {
    'title': '',
    'price': 0,
    'description': '',
    'imgUrl': '',
  };
  bool _isFirst = true;
  String? _arg;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isFirst) {
      _arg = ModalRoute.of(context)!.settings.arguments as String?;
      if (_arg != null) {
        Product _prod = Provider.of<Products>(context).findById(_arg!);
        prod['title'] = _prod.title;
        prod['price'] = _prod.price;
        prod['description'] = _prod.description;
        prod['imgUrl'] = _prod.imgUrl;
      }
      _isFirst = false;
    }
    super.didChangeDependencies();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_arg == null) {
      Provider.of<Products>(context, listen: false).addProduct(
        DateTime.now().toIso8601String(),
        prod['title'],
        prod['price'],
        prod['description'],
        prod['imgUrl'],
      );
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(
        _arg!,
        prod['title'],
        prod['price'],
        prod['description'],
        prod['imgUrl'],
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_arg == null ? 'Add Productd' : 'Edit Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: prod['title'],
                      keyboardType: TextInputType.text,
                      onSaved: (val) => prod['title'] = val!,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Product Title can not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.title_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: prod['price'].toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => prod['price'] = double.parse(val!),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Product Price can not be empty';
                        } else if (double.parse(val) <= 0) {
                          return 'Please enter valid price';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: prod['description'],
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      onSaved: (val) => prod['description'] = val!,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Product Description can not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.info_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: prod['imgUrl'],
                      keyboardType: TextInputType.url,
                      onSaved: (val) => prod['imgUrl'] = val!,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Product Image URL can not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: _onSave,
                child: Text(
                  _arg == null ? 'Add Productd' : 'Edit Product',
                  style: const TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).colorScheme.primary,
                minWidth: double.infinity,
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
