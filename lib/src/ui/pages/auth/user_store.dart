import 'package:flutter/foundation.dart';

import '../../../models/user_app.dart';

class UserStore with ChangeNotifier {
  UserStore._();
  static final store = UserStore._();

  late UserApp _user;

  UserApp get user => _user;
  set user(UserApp value) {
    _user = value;
    notifyListeners();
  }
}
