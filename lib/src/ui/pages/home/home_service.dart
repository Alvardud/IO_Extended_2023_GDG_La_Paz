import 'dart:convert';
import 'dart:developer';

import 'package:io_extended_2023_gdg_la_paz/src/config/middleware.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/service_config.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/home/home_store.dart';

class HomeService extends ServiceConfig {
  final store = HomeStore.store;

  HomeService(String route, super.url) {
    if (route != 'home_route') {
      throw 'Page not found';
    }
  }

  void getUsers() async {
    final response = await firestoreFetch('/');
    if (response.status == StatusNetwork.connected) {
      store.users =
          (response.data['list'] as List).map((e) => User.fromJson(e)).toList();
    }
  }

  void getUser(String id) async {
    final response = await firestoreFetch('/$id');
    if (response.status == StatusNetwork.connected) {}
  }
}
