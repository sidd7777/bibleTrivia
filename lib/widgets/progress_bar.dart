import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // Value should be between 0.0 and 1.0

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        LinearProgressIndicator(
          value: progress,
          minHeight: 20,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
        SizedBox(height: AppTheme.spaceSizeSmall),
        Text(
          '${(progress * 100).toStringAsFixed(0)}% Completed',
          style: TextStyle(color: AppTheme.textColor),
        ),
      ],
    );
  }
}
