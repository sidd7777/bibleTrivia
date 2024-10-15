import 'package:bible_trivia/core/app-theme/app_theme.dart';
import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed; // This is now required
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Icon? icon;
  final Image? image;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.icon,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buildButtonStyle(context),
      child: _buildButtonContent(),
    );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      foregroundColor: textColor ?? AppTheme.buttonTextColor,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.buttonPaddingVertical,
        horizontal: AppTheme.buttonPaddingHorizontal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
      ),
      // Set elevation to 0 to remove shadow
      elevation: 0,
      visualDensity: VisualDensity.compact, // Improve touch target
    );
  }

  Widget _buildButtonContent() {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor ?? AppTheme.buttonBackgroundColor,
            (backgroundColor ?? AppTheme.buttonBackgroundColor).withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
        border: Border.all(
          color: borderColor ?? AppTheme.buttonBackgroundColor,
        ),
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: AppTheme.buttonMinWidth,
          minHeight: AppTheme.buttonMinHeight,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) _buildIcon(),
            if (image != null) _buildImage(),
            Flexible(
              child: Text(
                buttonText,
                style: InheritedAppTheme.buttonTextStyle.copyWith(
                  fontSize: AppTheme.buttonTextSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: EdgeInsets.only(right: AppTheme.iconPadding),
      child: icon,
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.only(right: AppTheme.imagePadding),
      child: SizedBox(
        width: AppTheme.imageSize,
        height: AppTheme.imageSize,
        child: image,
      ),
    );
  }
}
