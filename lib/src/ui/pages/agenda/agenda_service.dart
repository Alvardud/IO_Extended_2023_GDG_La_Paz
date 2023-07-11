import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/agenda_data.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';

class AgendaService {
  final store = AgendaStore.store;

  void getTalks() async {
    store.talks = agendaData.map((e) => Talk.fromJson(e)).toList();
  }
}
