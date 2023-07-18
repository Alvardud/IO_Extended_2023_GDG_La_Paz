// To parse this JSON data, do
//
//     final teamMember = teamMemberFromJson(jsonString);

import 'dart:convert';

TeamMember teamMemberFromJson(String str) =>
    TeamMember.fromJson(json.decode(str));

String teamMemberToJson(TeamMember data) => json.encode(data.toJson());

class TeamMember {
  String? name;
  String? role;
  String? photoUrl;

  TeamMember({
    this.name,
    this.role,
    this.photoUrl,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        name: json["name"],
        role: json["role"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "photoUrl": photoUrl,
      };
}
