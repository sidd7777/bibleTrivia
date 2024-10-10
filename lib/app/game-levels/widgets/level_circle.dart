import 'package:flutter/material.dart';

class LevelCircle extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final Color? circleColor; // Optional color for the circle
  final double size; // Custom size for the circle

  const LevelCircle({
    required this.index,
    required this.onTap,
    this.circleColor,
    this.size = 50.0, // Default size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Material(
        elevation: 4, // Adding elevation for material effect
        shape: CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: circleColor ?? Colors.blue, // Use dynamic color
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
