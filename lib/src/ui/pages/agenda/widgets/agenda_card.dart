import 'dart:math';

import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';

import '../../../../models/talk.dart';

class AgendaCard extends StatelessWidget {
  AgendaCard({required this.talk, super.key});

  final Talk talk;
  final ValueNotifier<bool> isHoverNotifier = ValueNotifier<bool>(false);
  final Color color = AppColors.googleColors[Random().nextInt(
    AppColors.googleColors.length,
  )];

  @override
  Widget build(BuildContext context) {
    cardContent(bool roundBottom) => ValueListenableBuilder<bool>(
          valueListenable: isHoverNotifier,
          builder: (context, isHover, child) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                width: (constraints.maxWidth > 716)
                    ? 300
                    : MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.5,
                    color:
                        isHover ? AppColors.googleGrey900 : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(roundBottom ? 12 : 0),
                          bottomRight: Radius.circular(roundBottom ? 12 : 0),
                        ),
                        color: color,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      talk.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${talk.startHour} - ${talk.endHour}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          talk.speaker.photoPath.isEmpty
                              ? const SizedBox()
                              : Expanded(
                                  flex: 4,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: AssetImage(
                                            talk.speaker.photoPath,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 110,
                                      width: 110,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                    if (talk.type == 'talk' || talk.type == 'codelab')
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.googleGrey900,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text(
                          talk.speaker.name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (mouseHoverEvent) {
        isHoverNotifier.value = true;
      },
      onExit: (mouseExitEvent) {
        isHoverNotifier.value = false;
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      cardContent(false),
                      FutureBuilder<bool>(builder: (_, snapshot) {
                        return LayoutBuilder(
                            builder: (context, constraints) => Container(
                                  width: (constraints.maxWidth > 700)
                                      ? 300
                                      : MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: AppColors.googleGrey900,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Descripción de la charla/codelab:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        talk.description,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        'Acerca del speaker: ${talk.speaker.name}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        talk.speaker.bio,
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ));
                      })
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: cardContent(false),
      ),
    );
  }
}
