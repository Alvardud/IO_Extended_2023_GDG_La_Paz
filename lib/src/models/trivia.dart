import 'package:cloud_firestore/cloud_firestore.dart';

class Trivia {
  final String titulo;
  final bool estado;
  final List<Pregunta> preguntas;

  Trivia({
    required this.titulo,
    required this.estado,
    required this.preguntas,
  });

  factory Trivia.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Trivia(
      titulo: data['titulo'],
      estado: data['estado'],
      preguntas:
          data['preguntas'].map<Pregunta>((p) => Pregunta.fromJson(p)).toList(),
    );
  }
}

class Pregunta {
  final String pregunta;
  final List<Respuesta> respuestas;

  Pregunta({
    required this.pregunta,
    required this.respuestas,
  });

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      pregunta: json['pregunta'],
      respuestas: json['respuestas']
          .map<Respuesta>((respuesta) => Respuesta.fromJson(respuesta))
          .toList(),
    );
  }
}

class Respuesta {
  final String respuesta;
  final bool correcta;

  Respuesta({
    required this.respuesta,
    required this.correcta,
  });

  factory Respuesta.fromJson(Map<String, dynamic> json) {
    return Respuesta(
      respuesta: json['respuesta'],
      correcta: json['correcta'],
    );
  }
}
