import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/forgot_password_screen.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/login_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/onboarding/onboarding_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/portal/portal_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/qr/qr_screen.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/sponsors_page.dart';

import '../ui/pages/trivias/trivias_page.dart';

class Routes {
  static const home = HomePage.route;
  static const onboarding = OnboardingPage.route;
  static const portal = PortalPage.route;
  static const agenda = AgendaPage.route;
  static const login = LoginPage.route;
  static const sponsors = SponsorsPage.route;
  static const trivias = TriviasPage.route;
  static const qrScanner = QRScannerScreen.route;
  static const forgot = ForgotPasswordScreen.route;
}
