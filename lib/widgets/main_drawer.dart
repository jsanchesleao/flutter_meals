import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _MenuHeader(title: 'Cooking Up!',),
          SizedBox(height: 20),
          _MenuOption(
            title: 'Meals',
            icon: Icons.restaurant,
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _MenuOption(
            title: 'Filters',
            icon: Icons.settings,
            onTap: () => FiltersScreen.displayReplacement(context),
          ),
        ],
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {

  final String title;
  _MenuHeader({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      color: Theme.of(context).accentColor,
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  _MenuOption(
      {@required this.title, @required this.onTap, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
