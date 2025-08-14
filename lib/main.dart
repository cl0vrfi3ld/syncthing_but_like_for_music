// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// import 'package:flutter/material.dart';
//

import 'package:flutter/material.dart';
import 'package:syncthing_but_like_for_music/src/rust/api/sync_engine.dart';
import 'package:syncthing_but_like_for_music/src/rust/frb_generated.dart';

// async entrypoint
Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AppRoot(title: 'Sync Local Music App'),
    );
  }
}

class AppRoot extends StatefulWidget {
  final String title;
  // final List<Map<String, Object>> routes;

  const AppRoot({super.key, required this.title});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class AppRoute {
  final String name;
  final Widget icon;
  final Widget body;

  AppRoute({required this.name, required this.icon, required this.body});
}

final List<AppRoute> appRoutes = [
  AppRoute(name: "Text", icon: Icon(Icons.home), body: RteOne()),
  
  AppRoute(name: "Text", icon: Icon(Icons.favorite), body: Text("Text")),
];

class RteOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "I'm a Mac");
    return Container(
      child: Center(
        child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}

class _AppRootState extends State<AppRoot> {
  var selectedPageIndex = 0;
  
  // eventually the layout will need to dynamically switch to a bottom nav bar based on screen size
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              destinations: appRoutes
                  .map(
                    (route) => NavigationRailDestination(
                      icon: route.icon,
                      label: Text(route.name),
                    ),
                  )
                  .toList(),
              selectedIndex: selectedPageIndex,
              onDestinationSelected: (newRouteIndex) {
                setState(() {
                  selectedPageIndex = newRouteIndex;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
//         body: Center(
//           child: Text(
//             'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`',
//           ),
//         ),
//       ),
//     );
//   }
// }
