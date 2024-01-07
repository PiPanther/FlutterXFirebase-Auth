import 'package:flutter/material.dart';


class squareTile extends StatelessWidget {
  final String imagePath;
  const squareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade400,
      ),
      child: Image.asset(
        imagePath,
        height: 56,
      ),
    );
  }
}
