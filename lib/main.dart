import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/init_app.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/register_routes.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/user_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/ui/shared/app_colors.dart';

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
        final border = OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                color: AppColors.separator,
                width: 1,
                style: BorderStyle.solid));
        final borderFocus = OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                color: AppColors.textDark, width: 1, style: BorderStyle.solid));
        final baseTheme = ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            iconColor: AppColors.googleGrey900,
            hintStyle:
                const TextStyle(fontSize: 20, color: AppColors.labelInput),
            labelStyle:
                const TextStyle(fontSize: 20, color: AppColors.labelInput),
            floatingLabelStyle: const TextStyle(fontSize: 10),
            fillColor: AppColors.primaryLight,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
            errorStyle: const TextStyle(fontSize: 10),
            border: border,
            focusedBorder: borderFocus,
            disabledBorder: border,
            enabledBorder: border,
          ),
        );

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeStore.store),
            ChangeNotifierProvider(create: (context) => AgendaStore.store),
            ChangeNotifierProvider(
                lazy: true, create: (context) => UserStore.store)
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
