import 'package:bible_trivia/core/app-theme/app_theme.dart';
import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed; // This is now required
  final Color? backgroundColor; // Gradient starting color
  final Color? textColor; // Text color
  final Color? borderColor; // Border color
  final Icon? icon; // Optional icon
  final Image? image; // Optional image
  final bool isLoading; // Indicates loading state

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.icon,
    this.image,
    this.isLoading = false, // Default loading state is false
  });

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : _onPressed,
        style: _buildButtonStyle(context),
        child: _buildButtonContent(),
      ),
    );
  }

  void _onPressed() {
    _controller.forward().then((_) {
      // Call the onPressed callback
      widget.onPressed();
      _controller.reverse(); // Reverse the animation
    });
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      // Remove default background color to apply gradient
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.buttonPaddingVertical,
        horizontal: AppTheme.buttonPaddingHorizontal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
      ),
      elevation: 0, // Set elevation to 0 to remove shadow
      visualDensity: VisualDensity.compact, // Improve touch target
    );
  }

  Widget _buildButtonContent() {
    return Ink(
      decoration: BoxDecoration(
        // Gradient for button background
        gradient: LinearGradient(
          colors: [
            (widget.backgroundColor ?? AppTheme.accentColor).withOpacity(0.7),
            widget.backgroundColor ?? AppTheme.accentColor,
            (widget.backgroundColor ?? AppTheme.accentColor).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
        border: Border.all(
          color: widget.borderColor ?? AppTheme.buttonBackgroundColor, // Border color
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
            if (widget.icon != null) _buildIcon(),
            if (widget.image != null) _buildImage(),
            if (widget.isLoading) _buildLoadingIndicator(),
            if (!widget.isLoading) _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: EdgeInsets.only(right: AppTheme.iconPadding),
      child: widget.icon,
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.only(right: AppTheme.imagePadding),
      child: SizedBox(
        width: AppTheme.imageSize,
        height: AppTheme.imageSize,
        child: widget.image,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: AppTheme.buttonMinWidth * 0.6,
      height: AppTheme.buttonMinHeight * 0.6,
      child: CircularProgressIndicator(
        color: widget.textColor ?? Colors.white,
        strokeWidth: 2,
      ),
    );
  }

  Widget _buildText() {
    return Flexible(
      child: Text(
        widget.buttonText,
        style: InheritedAppTheme.buttonTextStyle.copyWith(
          fontSize: AppTheme.buttonTextSize,
          color: widget.textColor ?? Colors.black, // Ensure text is visible
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
