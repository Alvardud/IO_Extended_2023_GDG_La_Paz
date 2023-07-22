import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final _textController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
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
          onPressed: () => Navigator.pop(context, 'OK'),
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
