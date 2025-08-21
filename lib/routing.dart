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
  final bool player;

  const AppRoute({
    required this.name,
    required this.path,
    required this.icon,
    required this.iconOutlined,
    required this.body,
    this.player = false,
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

final mainAppRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          AppLayout(mainAppRoutes: mainAppRoutes, child: child),
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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Row(
              children: [
                NavigationRail(
              destinations: mainAppRoutes
                      .map(
                        (route) => NavigationRailDestination(
                          icon: route.icon,
                          label: Text(route.name),
                        ),
                      )
                      .toList(),
              selectedIndex: _getSelectedPageIndex(context, mainAppRoutes),
              onDestinationSelected: (index) =>
                  _setSelectedPageIndex(context, index, mainAppRoutes),
                ),
                child,
              ],
            ),
          ),
    );
  }
}
