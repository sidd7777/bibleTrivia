import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';
import '../main.dart';
import 'custom_list_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme
                  .drawerHeaderBackgroundColor, // Use AppTheme for background
            ),
            child: Text(
              AppTheme.quizMenuText,
              style: InheritedAppTheme
                  .drawerHeaderTextStyle, // Use AppTheme for text style
            ),
          ),
          CustomListTile(
            title: AppTheme.homeText,
            icon: Icons.home,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                    title: AppTheme.appBarTitleText,
                  ),
                ),
              );
            },
          ),
          CustomListTile(
            title: AppTheme.exitText,
            icon: Icons.exit_to_app,
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
