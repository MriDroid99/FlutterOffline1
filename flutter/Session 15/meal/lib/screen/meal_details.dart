import 'package:flutter/material.dart';
import 'package:meal2/provider/meal.dart';
import 'package:provider/provider.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int countIn = 0;
    int countSteps = 0;
    Map<String, dynamic> _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Meal _meal = Provider.of<Meals>(context).findById(_args['id']);
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.title),
      ),
      body: ListView(
        children: [
          ClipRRect(
            child: Image.network(_meal.imageUrl),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Card(
              child: ListView(
                children: [
                  ..._meal.ingredients.map((e) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${++countIn}'),
                      ),
                      title: Text(e),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            child: Card(
              child: ListView(
                children: [
                  ..._meal.steps.map((e) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${++countSteps}'),
                      ),
                      title: Text(e),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
