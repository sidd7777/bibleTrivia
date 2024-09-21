import 'package:flutter/material.dart';

import 'app_theme.dart';

class InheritedAppTheme {
  // Text Styles
  static TextStyle headerTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeSubTitle,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static TextStyle bodyTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeNormal,
    color: AppTheme.textColor,
  );

  static TextStyle secondaryTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeRegular,
    color: Colors.white70,
  );

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeRegular,
    color: AppTheme.buttonTextColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeSubTitle,
    color: AppTheme.textColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: AppTheme.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static const TextStyle drawerHeaderTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle drawerItemTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

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
}
