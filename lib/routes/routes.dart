import 'package:flutter/material.dart';

import '../routing.dart';
import 'home.dart';
import 'library/library.dart';
import 'player.dart';
import 'search.dart';

/// container class/object for our routes. this allows us to register all of our routes in one central object and derive routing logic, 
class AppRoutesConfig {
  final List<AppRoute> mainShellAppRoutes;
  final List<AppRoute> libraryRoutes;
  final PlayerRoute playerRoute;
  List<AppRoute> get allMainShellAppRoutes => mainAppRoutes + [playerRoute];

  AppRoutesConfig({
    required this.mainShellAppRoutes,
    required this.libraryRoutes,
    required this.playerRoute,
  });
}

final AppRoutesConfig appRoutesConfig = AppRoutesConfig(
  mainShellAppRoutes: _mainAppRoutes,
  libraryRoutes: _libraryAppRoutes,
  playerRoute: PlayerRoute(
    name: "Now Playing",
    path: '/player',
    icon: Icon(Icons.play_circle),
    iconOutlined: Icon(Icons.play_circle_outlined),
    body: RoutePlayer(),
  ),
);

/// a register of base app routes
final List<AppRoute> _mainAppRoutes = [
  AppRoute(
    name: "Home",
    icon: Icon(Icons.home),
    iconOutlined: Icon(Icons.home_outlined),
    body: RouteHome(),
    path: '/',
  ),
  AppRoute(
    name: "Library",
    path: '/library',
    icon: Icon(Icons.library_music),
    iconOutlined: Icon(Icons.library_music_outlined),
    body: RouteLibrary(),
  ),
  AppRoute(
    name: "Search",
    path: '/search',
    icon: Icon(Icons.search),
    iconOutlined: Icon(Icons.search_outlined),
    body: RouteSearch(),
  ),

  // AppRoute(
  //   name: "Text",
  //   icon: Icon(Icons.favorite),
  //   body: Text("Text"),
  //   path: '/text',
  // ),
];

final List<AppRoute> _libraryAppRoutes = [];
