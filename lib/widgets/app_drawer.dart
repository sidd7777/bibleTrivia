import 'package:bible_trivia/app/authenticate/sign-in/pages/common_login_page.dart';
import 'package:bible_trivia/app/profile/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/homepage/pages/home_page.dart';
import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';
import 'exit_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: AppTheme.drawerElevation,
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
                color: AppTheme.drawerHeaderBackgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTheme.quizMenuText,
                    style: InheritedAppTheme.drawerHeaderTextStyle,
                  ),
                  SizedBox(height: AppTheme.headerSpacing),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              title: AppTheme.homeText, // Use constant instead of hardcoded string
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
              title: AppTheme.profileText, // Use constant instead of hardcoded string
              icon: Icons.account_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            _buildDrawerItem(
              context,
              title: AppTheme.logoutText, // Use constant instead of hardcoded string
              icon: Icons.logout,
              onTap: _confirmLogOut(context),
            ),
          ],
        ),
      ),
    );
  }

  _confirmLogOut(BuildContext context) async {
    // Show the exit dialog before logging out
    final shouldLogout = await ExitDialog.show(
      context,
      AppTheme.logoutConfirmationTitle, // Use constant instead of hardcoded string
      AppTheme.logoutConfirmationMessage, // Use constant instead of hardcoded string
    );

    if (shouldLogout == true) {
      // User confirmed logout
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CommonLoginPage(),
        ),
      );
    }
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
            vertical: AppTheme.itemPaddingVertical, horizontal: AppTheme.itemPaddingHorizontal),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.itemBorderRadius),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.iconColor,
              size: AppTheme.spaceSizeLarge,
            ),
            SizedBox(width: AppTheme.itemSpacing),
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
