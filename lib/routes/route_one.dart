import 'package:flutter/material.dart';

import '../src/rust/api/sync_engine.dart';

class RouteOne extends StatelessWidget {
  const RouteOne({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "I'm a Mac");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}