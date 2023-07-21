

import 'package:io_extended_2023_gdg_la_paz/main.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/login_page.dart';

class TeamService{


  void signOut(){
    final auth = Auth();
    auth.signOut();
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  }
}