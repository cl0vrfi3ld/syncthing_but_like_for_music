import 'package:flutter/material.dart';

import '../src/rust/api/sync_engine.dart';

class RoutePlayer extends StatelessWidget {
  const RoutePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Player");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
