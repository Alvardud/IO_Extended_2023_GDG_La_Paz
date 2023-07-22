class Trivia {
  final String titulo;
  final bool estado;
  final List<Pregunta> preguntas;

  Trivia({
    required this.titulo,
    required this.estado,
    required this.preguntas,
  });
}

class Pregunta {
  final String pregunta;
  final List<Respuesta> respuestas;

  Pregunta({
    required this.pregunta,
    required this.respuestas,
  });
}

class Respuesta {
  final String respuesta;
  final bool correcta;

  Respuesta({
    required this.respuesta,
    required this.correcta,
  });
}
