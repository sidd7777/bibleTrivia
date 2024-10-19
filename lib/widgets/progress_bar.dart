import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // Value should be between 0.0 and 1.0
  final double height; // Height of the progress bar

  const ProgressBar({
    super.key,
    required this.progress,
    this.height = 20.0, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      children: [
        Text(
          'Game Progress',
          style: TextStyle(
            color: AppTheme.textColor,
            fontSize: AppTheme.fontSizeNormal,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppTheme.spaceSizeSmall),
        SizedBox(
          height: height, // Custom height for the progress bar
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
        ),
        SizedBox(height: AppTheme.spaceSizeSmall),
        Text(
          '${(progress * 100).toStringAsFixed(0)}% Completed',
          style: TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.w600, // Make it a bit bolder
          ),
        ),
      ],
    );
  }
}
