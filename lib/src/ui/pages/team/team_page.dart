import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/team_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/team_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/widgets/team_card.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  static const route = 'team';
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final service = TeamService('/');

  @override
  void initState() {
    service.getMemberTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    final store = context.watch<TeamStore>();
    return Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.background,
          title: Text(
            'Equipo',
            style: TextStyle(color: theme.fontColor),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              spacing: 25,
              runSpacing: 30,
              children: List.generate(store.memberTeam.length, (index) {
                final teamMember = store.memberTeam[index];
                return TeamCard(team: teamMember);
              }),
            ),
          ),
        ));
  }
}
