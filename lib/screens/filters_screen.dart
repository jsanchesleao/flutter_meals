import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  static void display(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  static void displayReplacement(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  _FiltersScreenState createState() => _FiltersScreenState();

  final Function onSave;
  final Map<String, bool> currentFilters;
  FiltersScreen({@required this.onSave, this.currentFilters});
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  void _handleOnSave() {
    widget.onSave({
      'gluten': _glutenFree,
      'vegan': _vegan,
      'vegetarian': _vegetarian,
      'lactose': _lactoseFree
    });
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _handleOnSave,
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                    title: Text('Gluten Free'),
                    subtitle: Text('Only include gluten free meals'),
                    value: _glutenFree,
                    onChanged: (newValue) {
                      setState(() => _glutenFree = newValue);
                    },
                  ),
                  SwitchListTile(
                    title: Text('Vegetarian'),
                    subtitle: Text('Only include vegetarian meals'),
                    value: _vegetarian,
                    onChanged: (newValue) {
                      setState(() => _vegetarian = newValue);
                    },
                  ),
                  SwitchListTile(
                    title: Text('Vegan'),
                    subtitle: Text('Only include vegan meals'),
                    value: _vegan,
                    onChanged: (newValue) {
                      setState(() => _vegan = newValue);
                    },
                  ),
                  SwitchListTile(
                    title: Text('Lactose Free'),
                    subtitle: Text('Only include lactose free meals'),
                    value: _lactoseFree,
                    onChanged: (newValue) {
                      setState(() => _lactoseFree = newValue);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
