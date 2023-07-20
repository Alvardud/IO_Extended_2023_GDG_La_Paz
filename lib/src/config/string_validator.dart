
  bool isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(email.trim());
}
String? validatorEmail(String v) {
  String? result = validator(v, 'Email');
  if (result == null) {
    if (isEmail(v)) {
      return null;
    } else {
      return 'Please enter a valid email address';
    }
  }
  return result;
}

String? validator(String value, String title) {
  if (value.trim().isEmpty) {
    return '$title not valid';
  }
  return null;
}