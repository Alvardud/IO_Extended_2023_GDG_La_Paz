import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/trivia.dart';

import '../../shared/app_colors.dart';

class TriviaAnswerPage extends StatefulWidget {
  const TriviaAnswerPage({
    super.key,
    required this.trivia,
  });

  final Trivia trivia;

  @override
  State<TriviaAnswerPage> createState() => _TriviaAnswerPageState();
}

class _TriviaAnswerPageState extends State<TriviaAnswerPage> {
  late List<QuestionBody> preguntas;
  final ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> puntajeNotifier = ValueNotifier<int>(0);
  final CountDownController controller = CountDownController();

  @override
  void initState() {
    super.initState();
    preguntas = List.generate(
      widget.trivia.preguntas.length,
      (index) {
        final pregunta = widget.trivia.preguntas[index];
        return QuestionBody(
          pregunta: pregunta,
          onRespuestaSelected: (respuesta) {
            if (respuesta.correcta) {
              puntajeNotifier.value = puntajeNotifier.value + 1;
            }

            if (indexNotifier.value == widget.trivia.preguntas.length - 1) {
              controller.pause();

              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                        'Tu puntaje es: ${puntajeNotifier.value} preguntas correctas'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop<int>(context, puntajeNotifier.value);
                        },
                        child: const Text('Aceptar'),
                      )
                    ],
                  );
                },
              );
            } else {
              indexNotifier.value = indexNotifier.value + 1;
            }
          },
          seconds: (index + 1) * 20,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responde la trivia y gana puntos'),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: indexNotifier,
        builder: (context, index, child) {
          return Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CircularCountDownTimer(
                duration: 30,
                initialDuration: 0,
                controller: controller,
                width: 80,
                height: 80,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.purpleAccent[100]!,
                fillGradient: null,
                backgroundColor: Colors.purple[500],
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Tu puntaje es: ${puntajeNotifier.value} preguntas correctas'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop<int>(
                                context,
                                puntajeNotifier.value,
                              );
                            },
                            child: const Text(
                              'Aceptar',
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  return Function.apply(defaultFormatterFunction, [duration]);
                },
              ),
              const SizedBox(
                height: 32,
              ),
              preguntas[index],
            ],
          );
        },
      ),
    );
  }
}

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    super.key,
    required this.pregunta,
    required this.onRespuestaSelected,
    required this.seconds,
  });

  final Pregunta pregunta;
  final Function(Respuesta) onRespuestaSelected;
  final int seconds;

  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Text(
            widget.pregunta.pregunta,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          Column(
            children: widget.pregunta.respuestas
                .map(
                  (r) => GestureDetector(
                    onTap: () {
                      widget.onRespuestaSelected(r);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.googleColors[
                            Random().nextInt(AppColors.googleColors.length)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        r.respuesta,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
