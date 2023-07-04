import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.route: (context) => const HomePage(),
  SplashScreen.route: (context) => const SplashScreen()
};
