import 'package:flutter/material.dart';
class RoundedImage extends StatelessWidget {
  final String imagePath;

  RoundedImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        imagePath,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}