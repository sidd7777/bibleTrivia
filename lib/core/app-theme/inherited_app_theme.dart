import 'package:flutter/material.dart';

import 'app_theme.dart';

class InheritedAppTheme {
  // Header and Title Styles
  static TextStyle get headerTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeSubTitle,
        fontWeight: FontWeight.bold,
        color: AppTheme.accentColor,
      );

  static TextStyle get titleTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeTitle,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      );

  // App Bar Style
  static TextStyle get appBarTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeSubTitle,
        color: AppTheme.backgroundColor,
        fontWeight: FontWeight.bold,
      );

  // Body Text Styles
  static TextStyle get bodyTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeNormal,
        color: AppTheme.accentColor,
      );

  static TextStyle get secondaryTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeRegular,
        color: Colors.white70,
      );

  // Button Styles
  static TextStyle get buttonTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeRegular,
        color: AppTheme.buttonTextColor,
        fontWeight: FontWeight.bold,
      );

  // Drawer Styles
  static const TextStyle drawerHeaderTextStyle = TextStyle(
    color: Colors.white,
    fontSize: AppTheme.fontSizeTitle, // Use AppTheme for size
    fontWeight: FontWeight.bold,
  );

  static TextStyle get drawerItemTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeRegular, // Use AppTheme for size
        color: Colors.white,
      );

  // Quiz and Game Styles
  static TextStyle get scoreTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeNormal,
        fontWeight: FontWeight.bold,
        color: AppTheme.buttonTextColor,
      );

  static TextStyle get questionTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeNormal,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      );

  static TextStyle get optionTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeNormal,
        color: AppTheme.buttonTextColor, // Inner text color
      );

  static TextStyle get inputLabelTextStyle => TextStyle(
        color: AppTheme.textColor,
        fontSize: AppTheme.fontSizeNormal,
      );

  static TextStyle get inputTextStyle => TextStyle(
        color: AppTheme.textColor,
        fontSize: AppTheme.fontSizeRegular,
      );

  static const TextStyle dialogTitleStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.dialogTitleColor,
  );

  static const TextStyle dialogMessageStyle = TextStyle(
    fontSize: 16.0,
    color: AppTheme.dialogContentColor,
  );

  static const TextStyle instructionTextStyle = TextStyle(
    fontSize: AppTheme.fontSizeRegular,
    color: AppTheme.textColor,
  );

  static TextStyle get baseTextStyle => TextStyle(
        fontSize: AppTheme.fontSizeNormal,
        color: AppTheme.textColor,
      );
}
