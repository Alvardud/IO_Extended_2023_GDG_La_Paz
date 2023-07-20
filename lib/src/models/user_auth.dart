class UserAuth {
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;
  UserAuth({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });
}
