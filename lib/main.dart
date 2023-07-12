import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/init_app.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/register_routes.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/splash_screen.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/team_store.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarIconBrightness: Brightness.light,
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InitAppController.instance.initTheme(),
      builder: (context, snapshot) {
        final baseTheme = ThemeData();

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeStore.store),
            ChangeNotifierProvider(create: (context) => AgendaStore.store),
            ChangeNotifierProvider(create: (context) => TeamStore.store),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'GDG La Paz',
            theme: baseTheme.copyWith(
              textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
              useMaterial3: true,
            ),
            routes: routes,
            initialRoute: SplashScreen.route,
          ),
        );
      },
    );
  }
}
