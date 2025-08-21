import 'package:flutter/material.dart';

import '../routing.dart';
import 'home.dart';
import 'library/library.dart';
import 'player.dart';
import 'search.dart';

/// a register of base app routes
final List<AppRoute> mainAppRoutes = [
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
  PlayerRoute(
    name: "Now Playing",
    path: '/player',
    icon: Icon(Icons.play_circle),
    iconOutlined: Icon(Icons.play_circle_outlined),
    body: RoutePlayer(),
  ),
  // AppRoute(
  //   name: "Text",
  //   icon: Icon(Icons.favorite),
  //   body: Text("Text"),
  //   path: '/text',
  // ),
];

final List<AppRoute> libraryAppRoutes = [];