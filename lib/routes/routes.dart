import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing.dart';
import 'home.dart';
import 'library/library.dart';
import 'settings/settings.dart';
import 'player.dart';
import 'search.dart';
import 'setup.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "MainAppShellNavigator",
);

final List<RouteBase> manualRouterConfig = [
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => AppLayout(
      mainAppRoutes: mainAppRoutes,
      playerRoute: playerRoute,
      child: child,
    ),
    routes: [
      GoRoute(
        name: "Home",
        path: "/",
        builder: (context, state) => RouteHome(),
      ),
      GoRoute(
        name: "Library",
        path: "/library",
        builder: (context, state) => RouteLibrary(),
      ),
      GoRoute(
        name: "Search",
        path: "/search",
        builder: (context, state) => RouteSearch(),
      ),
      GoRoute(
        name: "Settings",
        path: "/settings",
        builder: (context, state) => RouteSettingsRoot(),
      ),
    ],
  ),
  // the player should be outside the main shell so its screen is immersive.
  // this may change on bigger displays/devices to have the player still contained within the nav shell
  GoRoute(
    name: "Player",
    path: "/player",
    builder: (context, state) => RoutePlayer(),
  ),
  GoRoute(
    name: "Setup",
    path: "/setup",
    builder: (context, state) => RouteSetup(),
  ),
];

/// container class/object for our routes. this allows us to register all of our routes in one central object and derive routing logic,
class AppRoutesConfig {
  final List<AppRoute> mainShellAppRoutes;
  final List<AppRoute> libraryShellRoutes;
  final List<AppRoute> setupShellRoutes;
  final PlayerRoute playerRoute;
  List<AppRoute> get allMainShellAppRoutes => mainAppRoutes + [playerRoute];
  List<AppRoute> get navbarRoutes =>
      mainAppRoutes.where((i) => i.isUserRoutable).map((i) => i).toList();

  AppRoutesConfig({
    required this.mainShellAppRoutes,
    required this.libraryShellRoutes,
    required this.setupShellRoutes,
    required this.playerRoute,
  });
}

final AppRoutesConfig appRoutesConfig = AppRoutesConfig(
  mainShellAppRoutes: _mainAppRoutes,
  libraryShellRoutes: _libraryAppRoutes,
  setupShellRoutes: _setupShellRoutes,
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
  AppRoute(
    name: "Settings",
    path: '/settings',
    icon: Icon(Icons.settings),
    iconOutlined: Icon(Icons.settings_outlined),
    body: RouteSearch(),
  ),
  // AppRoute(name: "Setup", path: "/setup", body: RouteSetup()),
  // AppRoute(
  //   name: "Text",
  //   icon: Icon(Icons.favorite),
  //   body: Text("Text"),
  //   path: '/text',
  // ),
];

final List<AppRoute> _libraryAppRoutes = [];

final List<AppRoute> _setupShellRoutes = [];
