import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/member_team.dart';

class TeamCard extends StatelessWidget {
  final TeamMember team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(team.photoUrl!),
            backgroundColor: Colors.white,
          ),
          Column(children: [Text(team.name!), Text(team.role!)])
        ],
      ),
    );
  }
}
