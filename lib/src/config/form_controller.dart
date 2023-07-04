import 'package:flutter/material.dart';

mixin FormController {
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState != null) {
      return formKey.currentState!.validate();
    }
    return false;
  }

  String validateData(BuildContext context, String? value, String alias,
      {String? regExp}) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un texto aquí';
    }
    if (regExp != null) {
      if (!RegExp(regExp).hasMatch(value)) {
        return '$alias no válido';
      }
    }
    return "";
  }
}
