import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  OnboardingController() {
    pageIndex = 0;
  }
  late int pageIndex;

  void changePage(int? newIndex) {
    if (newIndex != null) {
      pageIndex = newIndex;
      notifyListeners();
    }
  }
}
