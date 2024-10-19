import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration; // For underline, strike-through, etc.
  final TextOverflow? overflow;
  final int? maxLines;
  final List<Shadow>? shadows; // Optional shadow effects
  final double? textScaleFactor; // For responsive text
  final bool isResponsive; // Flag to enable responsive sizing
  final TextStyle? style; // Optional TextStyle parameter

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.overflow,
    this.maxLines,
    this.shadows,
    this.textScaleFactor,
    this.isResponsive = false,
    this.style, // Optional TextStyle
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis, // Handle overflow gracefully
      maxLines: maxLines, // Limit the number of lines if needed
      style: style ?? _getTextStyle(context), // Use provided style or default
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return TextStyle(
      color: color ?? AppTheme.accentColor, // Use accent color from the theme
      fontSize: fontSize ?? AppTheme.fontSizeRegular, // Default font size
      fontWeight: fontWeight ?? FontWeight.normal, // Default weight is normal
      fontStyle: fontStyle ?? FontStyle.normal, // Can use italic if needed
      letterSpacing: letterSpacing ?? AppTheme.defaultLetterSpacing, // Use AppTheme constant
      wordSpacing: wordSpacing ?? AppTheme.defaultWordSpacing, // Use AppTheme constant
      height: height ?? AppTheme.defaultLineHeight, // Use AppTheme constant
      decoration: decoration, // Underline, strike-through, etc.
      shadows: shadows, // Apply any optional shadows
    );
  }
}
