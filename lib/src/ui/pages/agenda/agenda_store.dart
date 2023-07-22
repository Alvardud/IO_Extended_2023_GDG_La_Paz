import 'package:flutter/foundation.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';

class AgendaStore with ChangeNotifier {
  AgendaStore._();
  static final store = AgendaStore._();

  List<Talk> _talks = [];
  List<Talk> _technnicalTalks = [];
  List<Talk> _codelabs = [];

  List<Talk> get talks => _talks;
  set talks(List<Talk> value) {
    _talks = [...value];
    notifyListeners();
  }

  List<Talk> get technnicalTalks => _technnicalTalks;
  set technnicalTalks(List<Talk> value) {
    _technnicalTalks = [...value];
    notifyListeners();
  }

  List<Talk> get codelabs => _codelabs;
  set codelabs(List<Talk> value) {
    _codelabs = [...value];
    notifyListeners();
  }
}
