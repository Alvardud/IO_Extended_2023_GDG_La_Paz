import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/agenda/agenda_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/sponsors_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/team/team_page.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';

class _PortalNavItem {
  const _PortalNavItem({
    required this.icon,
    required this.label,
    required this.page,
    required this.index,
  });

  final Widget icon;
  final String label;
  final Widget page;
  final int index;
}

class PortalPage extends StatefulWidget {
  static const route = 'portal';

  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  final List<_PortalNavItem> _items = [
    const _PortalNavItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Inicio',
      page: HomePage(),
      index: 0,
    ),
    const _PortalNavItem(
      icon: Icon(
        Icons.calendar_month,
      ),
      label: 'Agenda',
      page: AgendaPage(),
      index: 1,
    ),
    const _PortalNavItem(
      icon: Icon(
        Icons.people,
      ),
      label: 'Sponsors',
      page: SponsorsPage(),
      index: 2,
    ),
     _PortalNavItem(
      icon: const Icon(
        Icons.local_hospital,
      ),
      label: 'Equipo',
      page: TeamPage(),
      index: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Scaffold(
          body: _items[selectedIndex].page,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            items: _items
                .map(
                  (item) => BottomNavigationBarItem(
                    backgroundColor: AppColors.googleBlue,
                    icon: item.icon,
                    label: item.label,
                  ),
                )
                .toList(),
            onTap: (index) {
              selectedIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }
}
