import 'package:flutter/material.dart';

// Model
import '../model/category.dart';

// Widget
import '../widget/categories_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = 'categories_screen';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: DUMMY_CATEGORIES.length,
        itemBuilder: (_, i) => CategoriesItem(
          DUMMY_CATEGORIES[i].id,
          DUMMY_CATEGORIES[i].title,
          DUMMY_CATEGORIES[i].color,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 150,
        ),
      ),
    );
  }
}
