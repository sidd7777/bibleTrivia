import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.showDrawer,
  });

  final String title;
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.accentColor, // Use your custom background color
      title: Text(
        title,
        style: InheritedAppTheme.appBarTextStyle, // Use your custom text style
      ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
