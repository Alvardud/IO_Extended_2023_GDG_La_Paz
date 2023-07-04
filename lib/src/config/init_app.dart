import 'package:io_extended_2023_gdg_la_paz/main.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';

class InitAppController {
  InitAppController._();

  static InitAppController instance = InitAppController._();

  Future<void> initTheme() async {
    await ThemeController.instance.initTheme();
  }

  Future<void> initApp() async {
    Map<String, dynamic> data = {};
    data['isLogin'] = false;

    //validar auth
    final token = await Auth().tokenApi;
    //if (token == '') {
    //  navigatorKey.currentState
    //      ?.pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
    //  return;
    //}

    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(HomePage.route, (route) => false);
    return;
  }
}
