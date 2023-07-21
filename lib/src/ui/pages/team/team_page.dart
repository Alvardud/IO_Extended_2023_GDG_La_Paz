import 'package:flutter/material.dart';

import 'team_service.dart';

class TeamPage extends StatelessWidget {
  TeamPage({super.key});
  final teamService = TeamService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                teamService.signOut();
              },
              child: const Text('Sign Out'))
        ],
      ),
      body: Center(
        child: Text('Team'),
      ),
    );
  }
}
