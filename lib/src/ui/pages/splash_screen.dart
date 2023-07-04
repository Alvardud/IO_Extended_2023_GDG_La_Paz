import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/init_app.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';

class SplashScreen extends StatefulWidget {
  static const route = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() async {
    await InitAppController.instance.initApp();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    return Scaffold(
      backgroundColor: theme.background,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: theme.success),
          ],
        ),
      ),
    );
  }
}
