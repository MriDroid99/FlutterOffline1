import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/meal.dart';

class CategoryMealItem extends StatefulWidget {
  const CategoryMealItem({Key? key}) : super(key: key);

  @override
  _CategoryMealItemState createState() => _CategoryMealItemState();
}

class _CategoryMealItemState extends State<CategoryMealItem> {
  String _convertComplexty(Complexity complexity) {
    switch (complexity) {
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Simple';
    }
  }

  String _convertAffordability(Affordability affordability) {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Luxurious';
    }
  }

  @override
  Widget build(BuildContext context) {
    final meal = Provider.of<Meal>(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/meal_details', arguments: {
        'id': meal.id,
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(meal.imageUrl),
                ),
                Positioned(
                  bottom: 30,
                  right: 0,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      meal.title,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MealCard(meal.duration, Icons.schedule),
                  MealCard(_convertComplexty(meal.complexity), Icons.work),
                  MealCard(_convertAffordability(meal.affordability),
                      Icons.attach_money),
                  IconButton(
                    onPressed: () {
                      if (meal.isFav) {
                        Provider.of<Meals>(context, listen: false)
                            .removeMeal(meal.id);
                      } else {
                        Provider.of<Meals>(context, listen: false)
                            .addMeal(meal.id);
                      }
                      setState(() {
                        meal.isFav = !meal.isFav;
                      });
                    },
                    icon: Icon(
                      meal.isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final dynamic label;
  final IconData icon;
  const MealCard(this.label, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 5,
        ),
        Text('$label')
      ],
    );
  }
}
