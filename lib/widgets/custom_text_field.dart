import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword; // New property to determine if it's a password field

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword, // Use isPassword to set obscureText
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: AppTheme.textColor),
          ),
          style: const TextStyle(color: AppTheme.textColor),
        ),
        const SizedBox(height: AppTheme.spaceSizeSmall), // Use theme spacing
      ],
    );
  }
}
