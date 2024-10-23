import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import 'custom_text.dart'; // Ensure CustomText is imported

class CustomListTile extends StatefulWidget {
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
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) {
      widget.onTap(); // Call the passed onTap function
      _controller.reverse(); // Reverse the animation after the action
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap, // Action when tapping the list tile
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        padding: EdgeInsets.all(AppTheme.listTilePadding), // Use constant for padding
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // Use surface color for background
          borderRadius: BorderRadius.circular(
              AppTheme.listTileBorderRadius), // Use constant for border radius
        ),
        child: Row(
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.icon,
                size: AppTheme.listTileIconSize, // Use constant for icon size
                color: AppTheme.iconColor, // Use AppTheme for icon color
              ),
            ),
            const SizedBox(width: AppTheme.spaceSizeMedium), // Space between icon and title
            Expanded(
              child: CustomText(
                // Use CustomText instead of Text
                text: widget.title,
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
