import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/member_team.dart';

class TeamStore extends ChangeNotifier {
  TeamStore._();
  static final store = TeamStore._();

  List<TeamMember> _memberTeams = [];

  List<TeamMember> get memberTeam => _memberTeams;
  set memberTeam(List<TeamMember> value) {
    _memberTeams = [...value];
    notifyListeners();
  }
}
