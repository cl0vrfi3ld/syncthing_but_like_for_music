import 'package:flutter/material.dart';

import '../src/rust/api/sync_engine.dart';

class RouteHome extends StatelessWidget {
  const RouteHome({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Home");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}