import 'package:io_extended_2023_gdg_la_paz/main.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user_app.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user_auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/user_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';

import '../../../config/middleware.dart';
import '../portal/portal_page.dart';

class LoginService extends ServiceConfig {
  final store = UserStore.store;
  LoginService(super.urlBase);

  Future<void> signInWithEmailAndPassword(UserAuth userAuth) async {
    final auth = Auth();

    final uid = await auth.signInWithEmailAndPassword(userAuth);
    final response = await firestoreFetch('/$uid');
    if (response.status == StatusNetwork.connected) {
      store.user = UserApp.fromMap(response.data);
      // navigatorKey.currentState?.pushNamedAndRemoveUntil(PortalPage.route, (route) => false);
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(HomePage.route, (route) => false);
    } else {
      throw 'Ocurrio un error inesperado';
    }
  }
}
