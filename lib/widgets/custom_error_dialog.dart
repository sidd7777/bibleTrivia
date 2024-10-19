import 'package:bible_trivia/core/app-theme/app_theme.dart'; // Adjust import based on your project structure
import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onClose;

  const CustomErrorDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0, // Remove default elevation
      backgroundColor: Colors.transparent, // Transparent background for animation
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.dialogPadding), // Use a constant from your theme
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Use surface color from theme
        borderRadius:
            BorderRadius.circular(AppTheme.dialogBorderRadius), // Use a constant for border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Size the dialog based on its content
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error, // Error color
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.dialogContentSpacing), // Use a constant for spacing
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, // Ensure contrast
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.dialogActionSpacing), // Use a constant for spacing
          CustomElevatedButton(
            buttonText: 'Close',
            onPressed: onClose,
            backgroundColor: AppTheme.primaryColor, // Use a constant for background color
            textColor: Colors.white, // Text color for visibility
          ),
        ],
      ),
    );
  }
}
