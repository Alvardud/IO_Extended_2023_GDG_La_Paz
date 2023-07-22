import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/routes.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/forgot_password_screen.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/login_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/onboarding/onboarding_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/qr/qr_screen.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/splash/splash_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/sponsors_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/trivias/trivias_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.route: (context) => const HomePage(),
  SplashScreen.route: (context) => const SplashScreen(),
  Routes.login: (_) => const LoginPage(),
  Routes.onboarding: (_) => const OnboardingPage(),
  Routes.agenda: (_) => const AgendaPage(),
  Routes.sponsors: (_) => const SponsorsPage(),
  Routes.trivias: (_) => const TriviasPage(),
  Routes.qrScanner:(_) => const QRScannerScreen(),
  Routes.forgot: (_) => const ForgotPasswordScreen(),
};
