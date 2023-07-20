// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class UserApp {
  UserApp({
    required this.fullName,
    required this.nickName,
    required this.email,
    required this.phoneNumber,
  });

  final String fullName;
  final String nickName;
  final String email;
  final String phoneNumber;

  

  UserApp copyWith({
    String? fullName,
    String? nickName,
    String? email,
    String? phoneNumber,
  }) {
    return UserApp(
      fullName: fullName ?? this.fullName,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'nickName': nickName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserApp.fromMap(Map<String, dynamic> map) {
    return UserApp(
      fullName: map['fullName'] as String,
      nickName: map['nickName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserApp.fromJson(String source) => UserApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserApp(fullName: $fullName, nickName: $nickName, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant UserApp other) {
    if (identical(this, other)) return true;
  
    return 
      other.fullName == fullName &&
      other.nickName == nickName &&
      other.email == email &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
      nickName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode;
  }
}
