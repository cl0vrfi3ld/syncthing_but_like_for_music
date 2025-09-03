import 'package:flutter/widgets.dart';
import '../src/rust/backend/net.dart';

class AppState {
  late NetController netController;
}

class AppStateModel extends ChangeNotifier {
  final AppState _appState = AppState();

  NetController get netController => _appState.netController;

  void setNetController(NetController controller) {
    _appState.netController = controller;
    notifyListeners();
  }

  // AppStateModel newWithNetController(NetController controller) {
  //   AppStateModel model =  AppStateModel();
  //   model._appState.netController = controller;
  //   return model;
  // }

}