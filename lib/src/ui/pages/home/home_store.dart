import 'package:flutter/foundation.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';

class HomeStore with ChangeNotifier {
  HomeStore._();
  static final store = HomeStore._();

  List<User> _users = [];

  List<User> get users => _users;
  set users(List<User> value) {
    _users = [...value];
    notifyListeners();
  }
}
