import 'package:flutter/material.dart';

import '../src/rust/api/sync_engine.dart';

class RouteSetup extends StatelessWidget {
  const RouteSetup({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Setup");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
