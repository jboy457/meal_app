import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';

  final String title;

  MealDetailScreen({this.title});

  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(child) {
    return Container(
      // color: Colors.white,
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
              width: double.infinity,
              height: 300,
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    color: Theme.of(context).accentColor,
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle('Steps', context),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(
                      selectedMeal.steps[index],
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),
    );
  }
}
