import 'package:flutter/material.dart';

import '../../src/rust/api/sync_engine.dart';

class RouteSettingsRoot extends StatelessWidget {
  const RouteSettingsRoot({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Settings");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}