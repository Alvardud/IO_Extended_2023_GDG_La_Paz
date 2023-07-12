import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/team_data.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/member_team.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/team_store.dart';

class TeamService extends ServiceConfig {
  final store = TeamStore.store;

  TeamService(super.urlBase);

  void getMemberTeam() async {
    store.memberTeam = teamData.map((e) => TeamMember.fromJson(e)).toList();
  }
}
