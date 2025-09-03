import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncthing_but_like_for_music/models/app_state.dart';
import 'package:syncthing_but_like_for_music/src/rust/api/sync_engine.dart';
import 'package:syncthing_but_like_for_music/src/rust/backend/net.dart';
import 'package:syncthing_but_like_for_music/src/rust/frb_generated.dart';

import 'routing.dart';

// async entrypoint
Future<void> main() async {
  // initialise rust code
  await RustLib.init();
  // initialise networking engine
  var netController = await initNetworking();

  // run the app
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        // make new state model
        AppStateModel model = AppStateModel();
        // assign networking controller to the state instance
        model.setNetController(netController);
        return model;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Provider.of<AppStateModel>(context, listen: false).setNetController(netController);
    return MaterialApp.router(
      routerConfig: mainAppRouter,
      title: 'Syncplay',

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
    );
  }
}
