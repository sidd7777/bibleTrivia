import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import 'custom_text.dart'; // Make sure to import the CustomText widget

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
    return GestureDetector(
      onTap: onTap, // Action when tapping the list tile
      child: Container(
        padding: EdgeInsets.all(AppTheme.listTilePadding), // Use constant for padding
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // Use surface color for background
          borderRadius: BorderRadius.circular(
              AppTheme.listTileBorderRadius), // Use constant for border radius
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppTheme.listTileIconSize, // Use constant for icon size
              color: AppTheme.iconColor, // Use AppTheme for icon color
            ),
            const SizedBox(width: 12), // Space between icon and title
            Expanded(
              child: CustomText(
                // Use CustomText instead of Text
                text: title,
                style: InheritedAppTheme.drawerItemTextStyle, // Use AppTheme for text style
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
