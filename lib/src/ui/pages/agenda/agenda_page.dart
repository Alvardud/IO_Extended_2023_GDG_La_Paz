import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/widgets/agenda_card.dart';

import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/spacing.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/widgets/arrow_back.dart';
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
    service.getTechnicalTalks();
/*     final auth = Auth();
    final uid = auth.getUid() ?? '';
    service.getUser(uid); */
    service.getCodelabs();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    final store = context.watch<AgendaStore>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.background,
          elevation: 0,
          title: Text(
            'Agenda',
            style: TextStyle(color: theme.fontColor),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Charlas',
              ),
              Tab(
                text: 'Codelabs',
              ),
            ],
          ),
          leading: const ArrowBack(),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                separatorBuilder: (context, index) => VerticalSpacing.l,
                itemCount: store.technnicalTalks.length,
                itemBuilder: (context, index) {
                  final talk = store.technnicalTalks[index];
                  return AgendaCard(
                    talk: talk,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                separatorBuilder: (context, index) => VerticalSpacing.l,
                itemCount: store.codelabs.length,
                itemBuilder: (context, index) {
                  final talk = store.codelabs[index];
                  return AgendaCard(
                    talk: talk,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
