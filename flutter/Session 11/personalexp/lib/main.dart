import 'package:flutter/material.dart';
import 'package:personalexp/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        colorScheme: const ColorScheme.light(
          secondary: Colors.indigoAccent,
        ),
        canvasColor: const Color.fromRGBO(255, 250, 250, 1),
      ),
      home: const HomeScreen(),
    );
  }
}
