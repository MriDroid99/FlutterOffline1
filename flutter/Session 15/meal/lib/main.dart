import 'package:flutter/material.dart';
import 'package:meal2/screen/meal_details.dart';
import 'package:provider/provider.dart';

// Provider
import './provider/meal.dart';

// Screen
import 'screen/tab_screen.dart';
import 'screen/categories_screen.dart';
import 'screen/category_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Meals(),
      child: MaterialApp(
        title: 'Meal',
        theme: ThemeData(
          primaryColor: Colors.pink,
          colorScheme: ColorScheme.light(
            primary: Colors.pink,
            secondary: Colors.amber,
          ),
          canvasColor: Color.fromRGBO(255, 250, 220, 1),
        ),
        // home: CategoriesScreen(),
        routes: {
          '/': (_) => TabScreen(),
          CategoriesScreen.routeName: (_) => CategoriesScreen(),
          CategoryMealsScreen.routeName: (_) => CategoryMealsScreen(),
          '/meal_details': (_) => MealDetailsScreen(),
        },
      ),
    );
  }
}
