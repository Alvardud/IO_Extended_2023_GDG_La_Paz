import 'package:io_extended_2023_gdg_la_paz/src/constants/agenda_data.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';

class AgendaService extends ServiceConfig {
  final store = AgendaStore.store;

  void getAllTalks() {
    store.talks = agendaData.map((e) => Talk.fromJson(e)).toList();
  }

  void getTechnicalTalks() {
    store.technnicalTalks = agendaData
        .map((e) => Talk.fromJson(e))
        .toList()
        .where((t) => t.type != "codelab")
        .toList();
  }

  void getCodelabs() {
    store.codelabs = agendaData
        .map((e) => Talk.fromJson(e))
        .toList()
        .where((t) => t.type == "codelab")
        .toList();
  }
}
