import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/theming.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/preferences_service.dart';

class ThemeController {
  ThemeController._();

  static final instance = ThemeController._();

  ValueNotifier<bool> brightness = ValueNotifier<bool>(true);
  bool get brightnessValue => brightness.value;

  //--------------------------------------------
  //Colors

  Color get background =>
      brightnessValue ? Theming.background : Theming.backgroundDark;

  Color get colorWeigth => brightnessValue ? Colors.white : Colors.black;
  Color get fontColor => brightnessValue ? Colors.black : Colors.white;

  Color get grey => brightnessValue ? Theming.grey : Theming.greyDark;
  Color get success => brightnessValue ? Theming.success : Theming.successDark;
  Color get danger => brightnessValue ? Theming.danger : Theming.dangerDark;
  Color get warning => brightnessValue ? Theming.warning : Theming.warningDark;
  Color get mainColor =>
      brightnessValue ? Theming.mainColor : Theming.mainColorDark;
  Color get secondaryColor =>
      brightnessValue ? Theming.secondaryColor : Theming.secondaryColorDark;
  Color get info => brightnessValue ? Theming.info : Theming.infoDark;

  //------------------------------------------------------
  //Theme Methods
  void changeTheme() async {
    brightness.value = !brightness.value;
    await PreferencesService.instance.setBool('theme', brightness.value);
  }

  Future<void> initTheme() async {
    brightness.value = await PreferencesService.instance.getBool('theme');
  }
}
