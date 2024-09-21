import 'dart:math' as math;

import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final int levels; // Number of levels (50)
  static List<Offset> circleCenters = [];

  PathPainter(this.levels);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    final waveAmplitude = size.width * 0.3; // Adjust amplitude
    final verticalSpacing =
        size.height / (levels + 2); // Spacing between levels
    const waveFrequency = 0.025; // Frequency of sine wave

    circleCenters.clear();

    // Create the sine wave path and store circle centers
    for (int i = 0; i < levels; i++) {
      final y = (i + 1) * verticalSpacing; // Start at the first button's level
      final x = size.width * 0.5 + waveAmplitude * math.sin(waveFrequency * y);

      // Only move to the first position without drawing a line before it
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Store circle center positions for buttons
      circleCenters.add(Offset(x, y));
    }

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
