import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/theme_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';
import 'package:provider/provider.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScaffoldMessenger(
          key: homePage,
          child: Scaffold(
            backgroundColor: theme.background,
            appBar: AppBar(
              backgroundColor: theme.background,
              elevation: 0,
              title: Text(
                'Google IO Extended',
                style: TextStyle(color: theme.fontColor),
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: store.users.length,
                  itemBuilder: (context, index) {
                    final user = store.users[index];
                    return ListTile(
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    );
                  },
                )),
          )),
    );
  }
}
