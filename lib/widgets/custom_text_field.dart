import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
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
            labelStyle: TextStyle(
                color: Colors.white, fontSize: AppTheme.fontSizeSmall), // Light label text
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorText: errorText,
            errorStyle: TextStyle(color: Colors.redAccent), // Error messages in light color
          ),
          style: TextStyle(
              color: Colors.white, fontSize: AppTheme.fontSizeNormal), // Light text in text field
          onChanged: onChanged,
        ),
        const SizedBox(height: AppTheme.spaceSizeSmall),
      ],
    );
  }
}
