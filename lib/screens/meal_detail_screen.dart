import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreenArguments {
  final Meal meal;
  MealDetailsScreenArguments({@required this.meal});
}

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  static void display(
      BuildContext context, MealDetailsScreenArguments arguments) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  final Function onToggleFavorite;
  final Function checkIsFavorite;
  MealDetailScreen(
      {@required this.onToggleFavorite, @required this.checkIsFavorite});

  Meal getMeal(BuildContext context) {
    MealDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments as MealDetailsScreenArguments;
    return args.meal;
  }

  @override
  Widget build(BuildContext context) {
    Meal meal = getMeal(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: _MealDetailScreenContent(
        image: _HeadingImage(meal.imageUrl),
        sections: [
          _Section(
            title: _SectionTitle('Ingredients'),
            body: _IngredientsList(meal.ingredients),
          ),
          _Section(
            title: _SectionTitle('Steps'),
            body: _StepsList(meal.steps),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          checkIsFavorite(meal.id) ? Icons.star : Icons.star_border
        ),
        onPressed: () => onToggleFavorite(meal.id),
      ),
    );
  }
}

class _MealDetailScreenContent extends StatelessWidget {
  final _HeadingImage image;
  final List<_Section> sections;

  _MealDetailScreenContent({@required this.image, @required this.sections});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [image, ...sections]),
    );
  }
}

class _HeadingImage extends StatelessWidget {
  final String url;
  _HeadingImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final _SectionTitle title;
  final Widget body;

  _Section({@required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[title, _SectionContainer(body)],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;

  _SectionContainer(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: child);
  }
}

class _IngredientsList extends StatelessWidget {
  final List<String> ingredients;

  _IngredientsList(this.ingredients);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(ingredients[index]),
          ),
        );
      },
    );
  }
}

class _StepsList extends StatelessWidget {
  final List<String> steps;
  _StepsList(this.steps);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text('${1 + index}'),
              ),
              title: Text(steps[index]),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
