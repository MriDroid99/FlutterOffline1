import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/meal.dart';

import '../widget/category_meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = 'category_meals_screen';
  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final meals = Provider.of<Meals>(context)
        .dummyMeals
        .where(
          (element) => element.categories.contains(
            arg['id'],
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('${arg['title']}'),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
          value: meals[i],
          child: CategoryMealItem(),
        ),
      ),
    );
  }
}
