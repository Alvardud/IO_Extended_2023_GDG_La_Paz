import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_extended_2023_gdg_la_paz/main.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/onboarding/onboarding_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/portal/portal_page.dart';

import '../locator/user_locator.dart';
import '../models/user_app.dart';
import '../plugins/auth/auth.dart';
import '../ui/pages/auth/login_page.dart';
import 'routes.dart';

class InitAppController {
  InitAppController._();

  static InitAppController instance = InitAppController._();

  Future<void> initTheme() async {
    await ThemeController.instance.initTheme();
  }

  void initApp() async {
    //validar auth
    // await Auth().signOut();
    final uid = Auth().getUid();
    if (uid == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginPage.route,
        (route) => false,
      );
      return;
    }
    final userSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    final userReference =
        FirebaseFirestore.instance.collection('usuarios').doc(uid);
    // store.user = UserApp.fromJson(response.data);
    userLocator.userApp = UserApp.fromSnapshotAndReference(
      userSnapshot,
      userReference,
    );
    // await Future.delayed(const Duration(seconds: 2));
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
  }
}
