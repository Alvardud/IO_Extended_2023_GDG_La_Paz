import 'package:flutter/material.dart';
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
              OptionCard(
                label: 'Nuestro equipo',
                backgroundColor: AppColors.googleYellow,
                imagePath: 'assets/images/dots.png',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
