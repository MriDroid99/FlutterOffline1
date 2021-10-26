import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/meal.dart';

// Widget
import '../widget/category_meal_item.dart';

class FavoriteMeals extends StatelessWidget {
  const FavoriteMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meals = Provider.of<Meals>(context).favoriteMeals;
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: meals[i],
        child: CategoryMealItem(),
      ),
    );
  }
}
