import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/firebase/firestore_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/widgets/option_card.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/spacing.dart';
import 'package:provider/provider.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                onTap: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
