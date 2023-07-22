import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/sponsor.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/shared/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsCard extends StatelessWidget {
  const SponsorsCard({
    super.key,
    required this.sponsor,
    this.fit = false,
  });

  final Sponsor sponsor;
  final bool fit;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(sponsor.facebookUrl));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    width: double.infinity,
                    color: sponsor.backgroundColor,
                    child: Image.asset(
                      sponsor.imageUrl,
                      fit: fit ? BoxFit.fitWidth : BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: AppColors.googleGrey900,
                    child: Center(
                      child: Text(
                        sponsor.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
