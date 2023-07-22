import 'package:io_extended_2023_gdg_la_paz/src/config/middleware.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/agenda_data.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';

class AgendaService extends ServiceConfig{
  final store = AgendaStore.store;

  AgendaService(String route, super.url) {
    if (route != 'agenda') {
      throw 'Page not found';
    }
  }

  void getTalks() async {
    store.talks = agendaData.map((e) => Talk.fromJson(e)).toList();
  }

  void getUser(String id) async {
    if(id.isEmpty) {
      throw 'Sin data';
    }
    final response = await firestoreFetch('/$id');
    if (response.status == StatusNetwork.connected) {
      store.user = User.fromJson(response.data);
    }
  }
}
