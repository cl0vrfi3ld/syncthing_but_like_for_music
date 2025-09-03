import 'package:flutter/material.dart';

import '../../src/rust/api/sync_engine.dart';

class RouteLibraryItemAlbum extends StatelessWidget {
  const RouteLibraryItemAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Hello!");
    return Center(
      child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
