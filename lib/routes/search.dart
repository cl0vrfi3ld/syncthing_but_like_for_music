import 'package:flutter/material.dart';

import '../src/rust/api/sync_engine.dart';

class RouteSearch extends StatelessWidget {
  const RouteSearch({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Search");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
