import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/locator/user_locator.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/trivia_answer/trivia_answer_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/spacing.dart';

import '../../../models/trivia.dart';
import '../../shared/app_colors.dart';

class TriviasPage extends StatefulWidget {
  static const route = 'trivias';

  const TriviasPage({super.key});

  @override
  State<TriviasPage> createState() => _TriviasPageState();
}

class _TriviasPageState extends State<TriviasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cuestionarios')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final querySnapshot = snapshot.data!;
              final queryDocumentSnapshot = querySnapshot.docs;

              final List<Trivia> trivias = [];

              for (final docSnapshot in queryDocumentSnapshot) {
                trivias.add(Trivia.fromDocumentSnapshot(docSnapshot));
              }

              return ListView.separated(
                separatorBuilder: (context, index) => VerticalSpacing.xxl,
                itemCount: trivias.length,
                itemBuilder: (context, index) {
                  final trivia = trivias[index];
                  return GestureDetector(
                    onTap: () async {
                      if (userLocator.cuestionariosRespondidos
                          .contains(trivia.titulo)) {
                        return;
                      }

                      if (trivia.estado) {
                        final puntaje = await Navigator.push<int>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TriviaAnswerPage(
                              trivia: trivia,
                            ),
                          ),
                        );

                        if (puntaje != null) {
                          final userSnapshot = await FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(userLocator.userApp.id)
                              .get();
                          final currentScore = (userSnapshot.data()
                              as Map<String, dynamic>)['score'] as int;
                          final newScore = currentScore + puntaje;

                          FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(userLocator.userApp.id)
                              .update(
                            {
                              'score': newScore,
                            },
                          );

                          final nuevosCuestionariosRespondidos =
                              List<String>.from(
                                  userLocator.cuestionariosRespondidos);
                          nuevosCuestionariosRespondidos.add(trivia.titulo);
                          userLocator.cuestionariosRespondidos =
                              nuevosCuestionariosRespondidos;

                          setState(() {});
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                'El cuestionario para esta charla no esta disponible en este momento',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Aceptar'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: trivia.estado
                                ? userLocator.cuestionariosRespondidos
                                        .contains(trivia.titulo)
                                    ? Colors.grey
                                    : AppColors.googleColors[Random()
                                        .nextInt(AppColors.googleColors.length)]
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            trivia.titulo,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        if (userLocator.cuestionariosRespondidos
                            .contains(trivia.titulo))
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
