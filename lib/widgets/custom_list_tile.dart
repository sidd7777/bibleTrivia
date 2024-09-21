import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.iconColor, // Use AppTheme for icon color
      ),
      title: Text(
        title,
        style: InheritedAppTheme
            .drawerItemTextStyle, // Use AppTheme for text style
      ),
      onTap: onTap, // Action when tapping the list tile
    );
  }
}
