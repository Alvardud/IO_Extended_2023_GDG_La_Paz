import 'package:flutter/foundation.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';

class SponsorsStore with ChangeNotifier {
  SponsorsStore._();
  static final store = SponsorsStore._();

  List<User> _users = [];

  List<User> get users => _users;
  set users(List<User> value) {
    _users = [...value];
    notifyListeners();
  }
}
