import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/locator/user_locator.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';

import '../../../../main.dart';
import '../../../models/user_app.dart';
import '../../../plugins/auth/auth.dart';
import '../auth/login_page.dart';
import '../auth/user_store.dart';
import '../onboarding/onboarding_page.dart';

class SplashService extends ServiceConfig {
  final store = UserStore.store;
  SplashService(super.urlBase);

  Future<void> initApp() async {
    //validar auth
    final uid = Auth().getUid();
    if (uid == null) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
      return;
    }
    // final response = await firestoreFetch('/$uid');
    final userSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    final userReference =
        FirebaseFirestore.instance.collection('usuarios').doc(uid);
    // store.user = UserApp.fromJson(response.data);
    userLocator.userApp = UserApp.fromSnapshotAndReference(
      userSnapshot,
      userReference,
    );
    await Future.delayed(const Duration(seconds: 2));
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(HomePage.route, (route) => false);
  }
}
