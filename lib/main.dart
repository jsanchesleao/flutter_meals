import 'package:flutter/material.dart';
import 'package:flutter_meals/dummy_data.dart';

import './models/meal.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    _filters = filterData;
    _availableMeals = DUMMY_MEALS.where(_checkFilters).toList();
  }

  bool _checkFilters(Meal meal) {
    return (!_filters['gluten'] || (meal.isGlutenFree == _filters['gluten'])) &&
           (!_filters['lactose'] || (meal.isLactoseFree == _filters['lactose'])) &&
           (!_filters['vegan'] || (meal.isVegan == _filters['vegan'])) &&
           (!_filters['vegetarian'] || (meal.isVegetarian == _filters['vegetarian']));
  }

  void _toggleFavorite(String id) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      home: TabsScreen(favoriteMeals: _favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (_) => CategoryMealsScreen(meals: _availableMeals),
        MealDetailScreen.routeName: (_) => MealDetailScreen(onToggleFavorite: _toggleFavorite, checkIsFavorite: _isMealFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(currentFilters: _filters, onSave: _setFilters)
      },
    );
  }
}
