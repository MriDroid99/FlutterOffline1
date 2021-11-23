import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/auth.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/provider/localdatabase.dart';
import 'package:shopapp/provider/order.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/screen/add_product.dart';
import 'package:shopapp/screen/auth_screen.dart';
import 'package:shopapp/screen/cart_screen.dart';
import 'package:shopapp/screen/manage_products_screen.dart';
import 'package:shopapp/screen/order_screen.dart';
import 'package:shopapp/screen/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(value: Products()),
        // ChangeNotifierProvider.value(value: Orders()),
        // ChangeNotifierProvider.value(value: CartItems()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: LocalDatabase()),
        ChangeNotifierProxyProvider<LocalDatabase, CartItems>(
          create: (_) => CartItems(),
          update: (_, db, oldCart) =>
              CartItems(dbRef: db.dbRef, items: oldCart?.items),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, oldOrder) => Orders(
            uid: auth.uid,
            token: auth.token,
            orders: oldOrder?.orders ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, oldProd) => Products(
            uid: auth.uid,
            token: auth.token,
            prods: oldProd?.prods ?? [],
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.pink,
            secondary: Colors.pink.shade300,
          ),
        ),
        home: Consumer2<Auth, LocalDatabase>(
          builder: (_, auth, db, child) {
            return FutureBuilder(
                future: db.createDB(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FutureBuilder(
                      future: auth.getData(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (auth.token == null) {
                            return const AuthScreen();
                          }
                          return const TabScreen();
                        }
                        return Container();
                      },
                    );
                  }
                  return Container();
                });
          },
        ),
        routes: {
          '/manage_products': (_) => const ManageProductsScreen(),
          '/tab': (_) => const TabScreen(),
          '/add': (_) => const AddProductScreen(),
          '/cart': (_) => const CartScreen(),
          '/order': (_) => const OrderScreen(),
          '/auth': (_) => const AuthScreen(),
        },
      ),
    );
  }
}
