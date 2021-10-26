import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal2/screen/category_meals_screen.dart';

class CategoriesItem extends StatelessWidget {
  final String id, label;
  final Color color;
  const CategoriesItem(this.id, this.label, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(CategoryMealsScreen.routeName, arguments: {
        'title': label,
        'id': id,
      }),
      child: Card(
        color: color,
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.acme(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
