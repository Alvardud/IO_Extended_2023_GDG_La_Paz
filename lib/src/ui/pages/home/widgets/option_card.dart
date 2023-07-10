import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    this.imagePath,
    this.padding,
  });

  final String label;
  final Color backgroundColor;
  final String? imagePath;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 12,
                child: SizedBox(
                  width: 540,
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              if (imagePath != null)
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: padding ?? const EdgeInsets.all(0),
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(
                        imagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
