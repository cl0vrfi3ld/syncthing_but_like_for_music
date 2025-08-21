// routing logic and types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/routes.dart';

class AppRoute {
  /// the title of the page
  final String name;

  /// the rotue/path of the pahe
  final String path;

  /// the icon representing the route
  final Icon icon;

  /// the outlined version of the route's icon
  final Icon iconOutlined;

  /// the actual widget/content to be rendered for the route
  final Widget body;

  const AppRoute({
    required this.name,
    required this.path,
    required this.icon,
    required this.iconOutlined,
    required this.body,
  });
}

/// AppRoute class with library-specific parameter options
class LibraryAppRoute extends AppRoute {
  LibraryAppRoute({
    required super.name,
    required super.path,
    required super.icon,
    required super.iconOutlined,
    required super.body,
  });
}

/// a special version of the AppRoute with extra metadata for our player wideget
class PlayerRoute extends AppRoute {
  final bool player;
  const PlayerRoute({
    this.player = true,
    required super.name,
    required super.path,
    required super.icon,
    required super.iconOutlined,
    required super.body,
  });
}

int _routeIndexFromPathSafe(String path, List<AppRoute> routes) {
  int currentIndex = routes.indexWhere((route) => route.path.startsWith(path));
  int safeIndex = currentIndex >= 0 ? currentIndex : 0;
  return safeIndex;
}

int _routeIndexFromPathUnsafe(String path, List<AppRoute> routes) {
  int currentIndex = routes.indexWhere((route) => route.path.startsWith(path));
  if (currentIndex < 0) {
    throw Error();
  } else {
    return currentIndex;
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "RootNavigator",
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "AppShellNavigator",
);

final mainAppRoutes = appRoutesConfig.mainShellAppRoutes;
final libraryAppRoutes = appRoutesConfig.libraryRoutes;
final playerRoute = appRoutesConfig.playerRoute;

final mainAppRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppLayout(
        mainAppRoutes: mainAppRoutes,
        playerRoute: playerRoute,
        child: child,
      ),
      routes: mainAppRoutes
          .map<RouteBase>(
            (route) => GoRoute(
              name: route.name,
              path: route.path,
              builder: (context, state) => route.body,
            ),
          )
          .toList(),
    ),
    GoRoute(
      name: playerRoute.name,
      path: playerRoute.path,
      builder: (context, state) => playerRoute.body,
    ),
  ],
);

class NoRouteDefined extends StatelessWidget {
  const NoRouteDefined({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("this is awkward..."));
  }
}

/// our primary app shell/layout widget, surrounds main views with nav and other context info
class AppLayout extends StatelessWidget {
  final List<AppRoute> mainAppRoutes;
  final PlayerRoute playerRoute;
  final Widget child;

  int _getSelectedPageIndex(BuildContext context, List<AppRoute> routes) {
    String currentPath = GoRouterState.of(context).uri.toString();
    return _routeIndexFromPathSafe(currentPath, routes);
  }

  void _setSelectedPageIndex(
    BuildContext context,
    int index,
    List<AppRoute> routes,
  ) {
    AppRoute route = routes[index];
    context.go(route.path);
  }

  const AppLayout({
    super.key,
    required this.child,
    required this.mainAppRoutes,
    required this.playerRoute,
  });

  @override
  Widget build(BuildContext context) {
    // add in now playing route
    final List<AppRoute> allRoutes = mainAppRoutes + [playerRoute];
    return Scaffold(
      body: SafeArea(
        child: Flex(
          // CHANGE THIS LATER WITH DYNAMIC LOGIC DEPENDING ON LAYOUT AND SCREEN SIZE
          direction: Axis.horizontal,
          children: [
            NavigationRail(
              destinations:
                  // iterate over main app routes
                  allRoutes
                      .map(
                        (route) => NavigationRailDestination(
                          icon: route.icon,
                          label: Text(route.name),
                        ),
                      )
                      .toList(),
              selectedIndex: _getSelectedPageIndex(context, allRoutes),
              onDestinationSelected: (index) =>
                  _setSelectedPageIndex(context, index, allRoutes),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
