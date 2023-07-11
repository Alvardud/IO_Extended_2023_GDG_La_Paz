import 'dart:convert';

List<Talk> talkFromJson(String str) =>
    List<Talk>.from(json.decode(str).map((x) => Talk.fromJson(x)));

String talkToJson(List<Talk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Talk {
  int order;
  String type;
  String startHour;
  String endHour;
  String title;
  String description;
  List<String> topics;
  List<String> resources;
  Speaker speaker;

  Talk({
    required this.order,
    required this.type,
    required this.startHour,
    required this.endHour,
    required this.title,
    required this.description,
    required this.topics,
    required this.resources,
    required this.speaker,
  });

  factory Talk.fromJson(Map<String, dynamic> json) => Talk(
        order: json["order"] ?? 0,
        type: json["type"] ?? '',
        startHour: json["startHour"] ?? '',
        endHour: json["endHour"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        topics: List<String>.from(json["topics"].map((x) => x)),
        resources: List<String>.from(json["resources"].map((x) => x)),
        speaker: Speaker.fromJson(json["speaker"] ?? Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "type": type,
        "startHour": startHour,
        "endHour": endHour,
        "title": title,
        "description": description,
        "topics": List<String>.from(topics.map((x) => x)),
        "resources": List<String>.from(resources.map((x) => x)),
        "speaker": speaker.toJson(),
      };
}

class Speaker {
  String name;
  String country;
  String header;
  String photoPath;
  String bio;
  List<String> socialLinks;

  Speaker({
    required this.name,
    required this.country,
    required this.header,
    required this.photoPath,
    required this.bio,
    required this.socialLinks,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        name: json["name"] ?? '',
        country: json["country"] ?? '',
        header: json["header"] ?? '',
        photoPath: json["photoPath"] ?? '',
        bio: json["bio"] ?? '',
        socialLinks: List<String>.from(
          (json["socialLinks"] ?? <String>[]).map((x) => x),
        ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "header": header,
        "photoPath": photoPath,
        "bio": bio,
        "socialLinks": List<String>.from(socialLinks.map((x) => x)),
      };
}
