import 'package:flutter/material.dart';

import 'app_theme.dart';

class InheritedAppTheme {
  // Header and Title Styles
  static TextStyle headerTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeSubTitle,
    fontWeight: FontWeight.bold,
    color: AppTheme.accentColor,
  );

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  // App Bar Style
  static TextStyle appBarTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeSubTitle,
    color: AppTheme.textColor,
    fontWeight: FontWeight.bold,
  );

  // Body Text Styles
  static TextStyle bodyTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeNormal,
    color: AppTheme.accentColor,
  );

  static TextStyle secondaryTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeRegular,
    color: Colors.white70,
  );

  // Button Styles
  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeRegular,
    color: AppTheme.buttonTextColor,
    fontWeight: FontWeight.bold,
  );

  // Drawer Styles
  static const TextStyle drawerHeaderTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle drawerItemTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  // Quiz and Game Styles
  static TextStyle scoreTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeNormal,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static TextStyle questionTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeNormal,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static TextStyle optionTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeNormal,
    color: AppTheme.textColor,
  );

  static const TextStyle inputLabelTextStyle = TextStyle(
    color: AppTheme.textColor, // Use the global text color from AppTheme
    fontSize: AppTheme.fontSizeNormal, // Example size, modify as per your design
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: AppTheme.textColor, // Use the global text color
    fontSize: AppTheme.fontSizeRegular, // Adjust font size as needed
  );
}
