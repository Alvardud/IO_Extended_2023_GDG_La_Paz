import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/sponsors/widgets/sponsors_card.dart';

class SponsorsPage extends StatelessWidget {
  const SponsorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Sponsors',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                const SponsorsCard(imagePath: 'assets/images/image-sponsors-1.png',label: 'Go Pro',),
                const SizedBox(height: 15,),
                const SponsorsCard(imagePath: 'assets/images/image-sponsors-2.png',label: 'La Cascada'),
                const SizedBox(height: 15,),
                const SponsorsCard(imagePath: 'assets/images/image-sponsors-3.png',label: 'MacDonalds'),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      )
    );
  }

}
