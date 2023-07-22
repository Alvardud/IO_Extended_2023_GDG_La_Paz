import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_service.dart';
import 'package:provider/provider.dart';

class DialogWidget extends StatefulWidget {
  final String talk;

  const DialogWidget({super.key, required this.talk});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final _textController = TextEditingController(text: '');
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    /* final user = AgendaStore.store.user; */
    return AlertDialog(
      title: const Text(
        'Realiza una Pregunta!',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'Pregunta tus dudas acerca de la charla y nuestro speaker la respondera.'),
          const SizedBox(
            height: 20,
          ),
          _editQuestion()
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance.collection('preguntas').add({
              'charla': widget.talk,
              'estado': false,
              'fecha': date.toString(),
              'idUsuario': /* auth.getUid()*/'',
              'nombreUsuario': /* '${user.firstName} ${user.lastName}' */'',
              'pregunta': _textController.text,
            });
            Navigator.pop(context);
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }

  Widget _editQuestion() {
    return Container(
      child: TextField(
        controller: _textController,
        decoration: const InputDecoration(
          helperText: 'Ej: Como se llega a hacer esto?, es mi duda.',
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
