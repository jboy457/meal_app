import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter_meal';

  final Function saveFilters;
  final Map<String, bool> selectedFilters;

  FiltersScreen(this.saveFilters, this.selectedFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _lactoseFree = false;
  var _glutenFree = false;
  var _vegeterian = false;
  var _vegan = false;

  @override
  initState() {
    _glutenFree = widget.selectedFilters['gluten'];
    _lactoseFree = widget.selectedFilters['lactose'];
    _vegeterian = widget.selectedFilters['vegeterian'];
    _vegan = widget.selectedFilters['vegan'];

    super.initState();
  }

  Widget _buildList(
    String title,
    String description,
    bool currentValue,
    Function updatedValue,
  ) {
    return SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updatedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Your Filters')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'vegan': _vegan,
                  'vegeterian': _vegeterian,
                  'lactose': _lactoseFree,
                  'gluten': _glutenFree,
                };
                widget.saveFilters(selectedFilters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection!!!',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildList(
                    'Gluten-Free',
                    'Only include gluten-free meals.',
                    _glutenFree,
                    (newValue) {
                      setState(
                        () {
                          _glutenFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildList(
                    'Lactose-Free',
                    'Only include lactose-free meals.',
                    _lactoseFree,
                    (newValue) {
                      setState(
                        () {
                          _lactoseFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildList(
                    'Vegan',
                    'Only include vegan meals.',
                    _vegan,
                    (newValue) {
                      setState(
                        () {
                          _vegan = newValue;
                        },
                      );
                    },
                  ),
                  _buildList(
                    'Vegeterian',
                    'Only include vegeterian meals.',
                    _vegeterian,
                    (newValue) {
                      setState(
                        () {
                          _vegeterian = newValue;
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
