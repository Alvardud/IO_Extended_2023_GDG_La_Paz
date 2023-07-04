import 'package:io_extended_2023_gdg_la_paz/src/models/persona.dart';

class User extends Persona {
  late String email;
  late String phoneNumber;
  late String password;
  late String? passwordConfirmation;
  late String? userkey;

  User(
    super.firstName,
    super.lastName,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.phoneNumber,
  );

  static empty() => User('', '', '', '', '', '');

  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    password = json['password'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data.addEntries(super.toJson().entries);
    data['email'] = email;
    data['phone'] = phoneNumber;
    data['password'] = password;
    data['userkey'] = '';
    return data;
  }
}
