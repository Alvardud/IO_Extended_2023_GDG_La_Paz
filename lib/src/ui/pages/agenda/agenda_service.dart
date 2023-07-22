// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/middleware.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/agenda_data.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/talk.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';

class AgendaService extends ServiceConfig {
  final store = AgendaStore.store;
  final auth = Auth();

  AgendaService(String route, super.url) {
    if (route != 'agenda') {
      throw 'Page not found';
    }
  }

  void getTalks() async {
    store.talks = agendaData.map((e) => Talk.fromJson(e)).toList();
  }

  void getUser(String id) async {
    if (id.isEmpty) {
      throw 'Sin data';
    }
    final response = await firestoreFetch('/$id');
    if (response.status == StatusNetwork.connected) {
      store.user = User.fromJson(response.data);
    }
  }

  Future<void> sendQuestion(String talk, String question, dynamic handlerMessage) async {
    final DateTime date = DateTime.now();
    final response = await firestoreFetch('/');
    if (response.status == StatusNetwork.connected) {
      await FirebaseFirestore.instance.collection('preguntas').add({
        'charla': talk,
        'estado': false,
        'fecha': date.toString(),
        'idUsuario': /* auth.getUid()*/ '',
        'nombreUsuario': /* '${user.firstName} ${user.lastName}' */ '',
        'pregunta': question,
      });
      handlerMessage('Pregunta Enviada');
      
    } else {
      handlerMessage('No estas conectado a internet \nIntenta de nuevo');
    }
    // if (response.status == StatusNetwork.noInternet ||
    //     response.status == StatusNetwork.timeout){

    //     }
    // final snackBar = const SnackBar(
    //   content: Text('no tienes conexion a internet'),
    //   duration: Duration(seconds: 2),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
