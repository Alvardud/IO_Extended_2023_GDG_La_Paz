import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/routes.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/onboarding/onboarding_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/portal/portal_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.route: (context) => const HomePage(),
  SplashScreen.route: (context) => const SplashScreen(),
  Routes.onboarding: (_) => const OnboardingPage(),
  Routes.portal: (_) => const PortalPage(),
  Routes.agenda: (_) => const AgendaPage(),
};
