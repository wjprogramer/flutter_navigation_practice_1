import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/data/veggie.dart';

class VeggiesListScreen extends StatelessWidget {
  final List<Veggie> veggies;
  final ValueChanged<Veggie> onTapped;

  VeggiesListScreen({
    @required this.veggies,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('水果列表'),),
      body: ListView(
        children: [
          for (var item in veggies)
            ListTile(
              title: Text('${item.name}'),
              subtitle: Text(item.categoryName),
              onTap: () => onTapped(item),
            )
        ],
      ),
    );
  }
}