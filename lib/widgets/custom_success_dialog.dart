import 'package:bible_trivia/core/app-theme/app_theme.dart'; // Import AppTheme
import 'package:flutter/material.dart';

import '../core/app-theme/inherited_app_theme.dart';
import 'custom_text.dart';

class CustomSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onClose;

  const CustomSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(text: title, style: InheritedAppTheme.dialogTitleStyle),
      content: CustomText(text: message, style: InheritedAppTheme.dialogMessageStyle),
      actions: [
        TextButton(
          onPressed: onClose,
          child: CustomText(text: AppTheme.closeButtonText),
        ),
      ],
    );
  }
}
