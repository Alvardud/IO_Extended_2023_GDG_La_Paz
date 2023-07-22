import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/locator/user_locator.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/widgets/option_card.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/trivias/trivias_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/spacing.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../sponsors/sponsors_page.dart';

GlobalKey<ScaffoldMessengerState> homePage =
    GlobalKey<ScaffoldMessengerState>();

class HomePage extends StatefulWidget {
  static const route = 'home_route';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = HomeService(HomePage.route, 'usuarios');
  final counterNotifier = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    service.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    final store = context.watch<HomeStore>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(
          SpacingValues.xxl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google-io-logo.png',
            ),
            VerticalSpacing.xxl,
            VerticalSpacing.l,
            OptionCard(
              backgroundColor: const Color(0xff121215),
              label: 'Agenda',
              padding: const EdgeInsets.only(
                top: 8,
              ),
              imagePath: 'assets/images/bus.png',
              onPressed: () {
                Navigator.pushNamed(context, AgendaPage.route);
              },
            ),
            VerticalSpacing.l,
            OptionCard(
              label: 'Sponsors',
              backgroundColor: AppColors.googleBlue,
              imagePath: 'assets/images/world.png',
              onPressed: () {
                Navigator.pushNamed(context, SponsorsPage.route);
              },
            ),
            VerticalSpacing.l,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TriviasPage.route);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.googleGreen,
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 12,
                        child: SizedBox(
                          width: 540,
                          child: Center(
                            child: Text(
                              'Cuestionarios',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: SizedBox(
                            height: 100,
                            child: Icon(
                              Icons.question_mark,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            VerticalSpacing.l,
            GestureDetector(
              onTap: () {
                print(userLocator.userApp.id);
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 48,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Hola soy: ${userLocator.userApp.fullName}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Paquete: ${userLocator.userApp.package}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('usuarios')
                                      .doc(userLocator.userApp.id)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final data = snapshot.data!.data()
                                          as Map<String, dynamic>;
                                      return Text(
                                        'Puntaje: ${data['score'] as int}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }

                                    return const SizedBox();
                                  },
                                ),
                                SizedBox(
                                  height: 250,
                                  width: 250,
                                  child: QrImageView(
                                    data: userLocator.userApp.id,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.googleRed,
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 12,
                        child: SizedBox(
                          width: 540,
                          child: Center(
                            child: Text(
                              'Perfil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: SizedBox(
                            height: 100,
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
