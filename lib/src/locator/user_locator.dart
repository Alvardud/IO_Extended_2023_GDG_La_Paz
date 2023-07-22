import 'package:io_extended_2023_gdg_la_paz/src/models/user_app.dart';

class UserLocator {
  static final _singleton = UserLocator._();

  late UserApp userApp;
  late List<String> cuestionariosRespondidos;

  UserLocator._() {
    userApp = UserApp.empty;
    cuestionariosRespondidos = <String>[];
  }

  factory UserLocator() => _singleton;
}

UserLocator userLocator = UserLocator();
