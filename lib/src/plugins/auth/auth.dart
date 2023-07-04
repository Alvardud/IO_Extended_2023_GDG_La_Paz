import 'dart:convert';
import 'dart:developer';

import 'package:io_extended_2023_gdg_la_paz/src/models/user.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/preferences_service.dart';

class Auth {
  String? token;
  User? user;

  bool unathorized = false;
  final PreferencesService _preferencesService = PreferencesService.instance;

  Auth({this.token, this.user});

  Auth.fromJson(Map<String, dynamic> json) {
    user = json['data'] != null ? User.fromJson(json['data']) : null;
    token = json['token'];
  }

  Future<void> saveCredentials() async {
    if (user != null) {
      await _preferencesService.setString(
          "profile", jsonEncode(user!.toJson()));
    }

    if (token != null) {
      await _preferencesService.setString(
          "token", jsonEncode(token!.replaceAll('"', '')));
      await _preferencesService.setBool('unathorized', false);
    }
  }

  Future<void> updateUser() async {
    if (user != null) {
      await _preferencesService.setString(
          "profile", jsonEncode(user!.toJson()));
    }
  }

  Future<void> logout() async {
    try {
      await clearCredentials();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clearCredentials() async {
    await _preferencesService.setString("profile", "");
    await _preferencesService.setString("token", "");
    await _preferencesService.setBool("unathorized", true);
  }

  Future<String> get tokenApi async {
    String token = '';
    token = await _preferencesService.getString("token");
    return token;
  }

  Future<User> get person async {
    User user = User.empty();
    user = User.fromJson(
        jsonDecode(await _preferencesService.getString('profile')));
    return user;
  }
}
