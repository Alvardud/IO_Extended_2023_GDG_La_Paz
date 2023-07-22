import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_extended_2023_gdg_la_paz/main.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/locator/user_locator.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user_app.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user_auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/user_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';

import '../../../config/routes.dart';

class LoginService extends ServiceConfig {
  final store = UserStore.store;
  LoginService(super.urlBase);

  Future<void> signInWithEmailAndPassword(UserAuth userAuth) async {
    final auth = Auth();

    final uid = await auth.signInWithEmailAndPassword(userAuth);
    // final response = await firestoreFetch('/$uid');
    final userSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    final reference =
        FirebaseFirestore.instance.collection('usuarios').doc(uid);

    try {
      userLocator.userApp =
          UserApp.fromSnapshotAndReference(userSnapshot, reference);
      // navigatorKey.currentState?.pushNamedAndRemoveUntil(PortalPage.route, (route) => false);
      // navigatorKey.currentState
      //     ?.pushNamedAndRemoveUntil(HomePage.route, (route) => false);
      if (userLocator.userApp.role == 0) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          HomePage.route,
          (route) => false,
        );
        return;
      } else {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.qrScanner,
          (route) => false,
        );
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
