import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.showDrawer,
    this.actions, // Optional actions for the AppBar
    this.centerTitle = true, // Optional parameter for title alignment
    this.elevation = 4.0, // Default elevation value
  });

  final String title;
  final bool showDrawer;
  final List<Widget>? actions; // Optional list of action widgets
  final bool centerTitle; // Optional parameter for title alignment
  final double elevation; // Elevation of the AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.accentColor, // Use your custom background color
      title: Text(
        title,
        style: InheritedAppTheme.appBarTextStyle, // Use your custom text style
      ),
      centerTitle: centerTitle, // Center the title based on the parameter
      leading: showDrawer
          ? Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
          : null,
      automaticallyImplyLeading: false,
      actions: actions, // Add action buttons if provided
      elevation: elevation, // Set elevation
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
