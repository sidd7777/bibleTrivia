import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon; // Add prefixIcon property
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon, // Include prefixIcon in the constructor
    this.onChanged,
    this.errorText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            labelStyle: TextStyle(fontSize: AppTheme.fontSizeSmall),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon, // Add prefixIcon to decoration
            errorText: errorText,
          ),
          style: TextStyle(fontSize: AppTheme.fontSizeNormal),
          onChanged: onChanged,
        ),
        const SizedBox(height: AppTheme.spaceSizeSmall),
      ],
    );
  }
}
