import 'package:flutter/material.dart';

import '../ui/shared/extensions.dart';

class Sponsor {
  const Sponsor({
    required this.name,
    required this.facebookUrl,
    required this.imageUrl,
    required this.backgroundColor,
  });

  final String name;
  final String facebookUrl;
  final String imageUrl;
  final Color backgroundColor;

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      name: json['name'],
      facebookUrl: json['facebookUrl'],
      imageUrl: json['imageUrl'],
      backgroundColor: HexColor.fromHex(json['backgroundColor']),
    );
  }
}
