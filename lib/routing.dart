// routing logic and types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  final String name;
  final String path;
  final Widget icon;
  final Widget body;

  AppRoute({
    required this.name,
    required this.path,
    required this.icon,
    required this.body,
  });
}

abstract class LayoutWidget extends StatelessWidget {
  final Widget child;

  const LayoutWidget({super.key, required this.child});

  // @override
  // Widget build(BuildContext context) => child;

  // @override
  // Element createElement() {

  //   child
  //   // TODO: implement createElement
  //   throw UnimplementedError();
  // }
}

class TheRouter {
  late final GoRouter router;
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();
  final Widget layout;
  final List<AppRoute> routes;

  void initRouter() {
    final initRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: [
        ShellRoute(
          // path: '/',
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => layout,
          routes: routes
              .map<RouteBase>(
                (route) => GoRoute(
                  path: '/${route.path}',
                  builder: (context, state) => route.body,
                ),
              )
              .toList(),
        ),
      ],
    );
    router = initRouter;
  }

  TheRouter({required this.routes, required this.layout});
}
