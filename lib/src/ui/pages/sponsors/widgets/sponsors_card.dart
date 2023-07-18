import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/constants/theming.dart';

class SponsorsCard extends StatelessWidget {

  const SponsorsCard({super.key, required this.imagePath,required this.label});
  final String? imagePath;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theming.backgroundDark,width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imagePath != null)
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  child: Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: SizedBox(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}