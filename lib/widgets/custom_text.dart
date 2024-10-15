import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        color: color ?? AppTheme.accentColor, // Default color is black
        fontSize: fontSize ?? AppTheme.fontSizeRegular, // Default font size is 16
        fontWeight: fontWeight ?? FontWeight.normal, // Default font weight is normal
      ),
    );
  }
}
