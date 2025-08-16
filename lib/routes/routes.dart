import 'package:flutter/material.dart';

import '../routing.dart';
import 'route_one.dart';

final List<AppRoute> appRoutes = [
  AppRoute(name: "Home", icon: Icon(Icons.home), body: RouteOne(), path: '/'),

  AppRoute(
    name: "Text",
    icon: Icon(Icons.favorite),
    body: Text("Text"),
    path: '/text',
  ),
];