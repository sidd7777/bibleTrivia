import 'package:flutter/material.dart';

import '../app/homepage/pages/home_page.dart';
import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: AppTheme.drawerElevation, // Use a constant for elevation
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.drawerBackgroundColor,
              AppTheme.drawerHeaderBackgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.drawerHeaderBackgroundColor, // Same as drawer's background color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTheme.quizMenuText,
                    style: InheritedAppTheme.drawerHeaderTextStyle,
                  ),
                  SizedBox(height: AppTheme.headerSpacing), // Use a constant for spacing
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              title: AppTheme.homeText,
              icon: Icons.home,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      title: AppTheme.appBarTitleText,
                    ),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              context,
              title: AppTheme.exitText,
              icon: Icons.exit_to_app,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        // Trigger the tap effect
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
            vertical: AppTheme.itemPaddingVertical, horizontal: AppTheme.itemPaddingHorizontal),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.itemBorderRadius),
          color: Colors.transparent, // Set color for hover effect
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.iconColor), // Use AppTheme for icon color
            SizedBox(width: AppTheme.itemSpacing), // Use a constant for spacing
            Text(
              title,
              style: InheritedAppTheme.drawerItemTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
