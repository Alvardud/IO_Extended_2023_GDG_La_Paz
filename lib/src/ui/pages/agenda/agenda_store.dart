import 'package:flutter/foundation.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';

class AgendaStore with ChangeNotifier {
  AgendaStore._();
  static final store = AgendaStore._();

  List<Talk> _talks = [];

  List<Talk> get talks => _talks;
  set talks(List<Talk> value) {
    _talks = [...value];
    notifyListeners();
  }
}
