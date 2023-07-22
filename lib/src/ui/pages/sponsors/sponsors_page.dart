import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/sponsors_service.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/widgets/sponsors_card.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/widgets/arrow_back.dart';

class SponsorsPage extends StatelessWidget {
  static const String route = 'sponsors';

  const SponsorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sponsors'),
        leading: const ArrowBack(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: SponsorsService().getSponsors().map((sponsor) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: SponsorsCard(
                    sponsor: sponsor,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
