import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {
  final String imagePath;
  final String brandName;
  final bool isSelected;
  final VoidCallback onTap;

  BrandIcon({
    required this.imagePath,
    required this.brandName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(150),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Image.asset(imagePath, height: 33, width: 33),
              ),
              if (isSelected) ...[
                SizedBox(width: 8),
                Text(
                  brandName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
