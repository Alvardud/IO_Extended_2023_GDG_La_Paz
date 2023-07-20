

import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';

import '../../../../main.dart';
import '../../../models/user_app.dart';
import '../../../plugins/auth/auth.dart';
import '../auth/login_page.dart';
import '../auth/user_store.dart';
import '../onboarding/onboarding_page.dart';

class SplashService extends ServiceConfig{
  final store = UserStore.store;
  SplashService(super.urlBase);


  Future<void> initApp() async {
    //validar auth
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(OnboardingPage.route, (route) => false);
        return;
    final uid =  Auth().getUid();
    if (uid == null) {
      
      navigatorKey.currentState
         ?.pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
        return; 
    }
    final response = await firestoreFetch('/$uid');
    store.user = UserApp.fromMap(response.data);
    await Future.delayed(const Duration(seconds: 2));
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(OnboardingPage.route, (route) => false);
  }
}