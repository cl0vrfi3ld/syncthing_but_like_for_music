import 'package:flutter/material.dart';

import '../routing.dart';
import 'home.dart';
import 'library/library.dart';
import 'player.dart';
import 'search.dart';

final List<AppRoute> appRoutes = [
  AppRoute(name: "Home", icon: Icon(Icons.home), body: RouteHome(), path: '/'),
  AppRoute(name: "Library", path: '/library', icon: Icon(Icons.library_music), body: RouteLibrary()),
  AppRoute(name: "Search", path: '/search', icon: Icon(Icons.search), body: RouteSearch()),
  AppRoute(name: "Now Playing", path: '/player', icon: Icon(Icons.play_circle), body: RoutePlayer(),player: true),
  // AppRoute(
  //   name: "Text",
  //   icon: Icon(Icons.favorite),
  //   body: Text("Text"),
  //   path: '/text',
  // ),
];