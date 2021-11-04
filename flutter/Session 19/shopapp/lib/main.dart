import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/screen/add_product.dart';
import 'package:shopapp/screen/manage_products_screen.dart';
import 'package:shopapp/screen/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.pink,
            secondary: Colors.pink.shade300,
          ),
        ),
        home: const TabScreen(),
        routes: {
          '/manage_products': (_) => const ManageProductsScreen(),
          '/tab': (_) => const TabScreen(),
          '/add': (_) => const AddProductScreen(),
        },
      ),
    );
  }
}
