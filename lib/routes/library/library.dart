import 'package:flutter/material.dart';

import '../../src/rust/api/sync_engine.dart';

class RouteLibrary extends StatelessWidget {
  const RouteLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Library");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}