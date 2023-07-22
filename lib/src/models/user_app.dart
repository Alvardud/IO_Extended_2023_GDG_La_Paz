// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  UserApp({
    required this.email,
    required this.fullName,
    required this.package,
    required this.score,
    required this.acreditacion,
    required this.id,
  });

  final String email;
  final String fullName;
  final String package;
  final int score;
  final bool acreditacion;
  final String id;

  static UserApp get empty => UserApp(
        email: '',
        fullName: '',
        package: '',
        score: 0,
        acreditacion: false,
        id: '',
      );

  UserApp copyWith({
    String? email,
    String? fullName,
    String? package,
    int? score,
    bool? acreditacion,
    String? id,
  }) {
    return UserApp(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      package: package ?? this.package,
      score: score ?? this.score,
      acreditacion: acreditacion ?? this.acreditacion,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullName': fullName,
      'package': package,
      'score': score,
      'acreditacion': acreditacion,
    };
  }

  factory UserApp.fromSnapshotAndReference(
    DocumentSnapshot snapshot,
    DocumentReference reference,
  ) {
    final map = snapshot.data() as Map<String, dynamic>;
    return UserApp(
      email: map['email'],
      fullName: map['fullName'],
      package: map['package'],
      score: map['score'],
      acreditacion: map['acreditacion'],
      id: reference.id,
    );
  }

  // factory UserApp.fromJson(Map<String, dynamic> map) {
  //   return UserApp(
  //     email: map['email'] ?? '',
  //     fullName: map['fullName'] ?? '',
  //     package: map['package'] ?? '',
  //     score: map['score'] ?? 0,
  //     acreditacion: map['acreditacion'] ?? false,
  //     reference: null,
  //   );
  // }

  String toJson() => json.encode(toMap());
}
