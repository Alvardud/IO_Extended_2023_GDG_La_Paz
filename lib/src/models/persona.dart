class Persona {
  late String firstName;
  late String lastName;

  Persona(this.firstName, this.lastName);

  static empty() => Persona('', '');

  Persona.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
