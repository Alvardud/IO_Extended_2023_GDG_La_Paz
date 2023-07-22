import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/spacing.dart';
import 'package:provider/provider.dart';

class AgendaPage extends StatefulWidget {
  static const route = 'agenda';

  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final service = AgendaService();

  @override
  void initState() {
    super.initState();
    service.getTalks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    final store = context.watch<AgendaStore>();

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(
          'Talks',
          style: TextStyle(color: theme.fontColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) => VerticalSpacing.l,
          itemCount: store.talks.length,
          itemBuilder: (context, index) {
            final talk = store.talks[index];
            final isTalk = talk.type == 'talk' || talk.type == 'codelab';
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isTalk ? 0 : 12),
                      bottomRight: Radius.circular(isTalk ? 0 : 12),
                    ),
                    color: AppColors.googleColors[
                        Random().nextInt(AppColors.googleColors.length)],
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
                                if (talk.type == 'talk' ||
                                    talk.type == 'codelab')
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            //TODO: DIAGLOG
                                            return AlertDialog();
                                            // return MakeQuestionWidget();
                                          });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.googleGrey900,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Pregunta',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
            );
          },
        ),
      ),
    );
  }
}
