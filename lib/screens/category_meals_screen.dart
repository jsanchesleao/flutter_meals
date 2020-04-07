import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreenArguments {
  String categoryId;
  String categoryTitle;
  CategoryMealsScreenArguments(
      {@required this.categoryId, @required this.categoryTitle});
}

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  static void display(
      BuildContext context, CategoryMealsScreenArguments arguments) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  final List<Meal> meals;
  CategoryMealsScreen({@required this.meals});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as CategoryMealsScreenArguments;

    final categoryMeals = meals
        .where((meal) => meal.categoryIds.contains(args.categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(args.categoryTitle),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: categoryMeals[index],
        ),
      ),
    );
  }
}
