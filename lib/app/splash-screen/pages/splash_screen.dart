import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller and animation for fade-in and fade-out
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Sequence of fade-in and fade-out
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50, // First half for fade-in
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50, // Second half for fade-out
      ),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navigate back to the home page after animation completes
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: AppTheme.appBarTitleText),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Updated to use AppTheme
      body: Center(
        child: Opacity(
          opacity: _animation.value, // Apply both fade-in and fade-out animations
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Updated to use theme-based color for the icon
              Icon(
                Icons.flutter_dash_sharp, // Replace with your app logo
                color: AppTheme.primaryColor, // Use AppTheme primary color
                size: 200.0,
              ),
              const SizedBox(height: AppTheme.spaceSizeMedium),
              // Splash screen text with inherited theme styles
              Text(
                'Bible Trivia',
                style: InheritedAppTheme.headerTextStyle.copyWith(
                  // Updated to use header text style
                  color:
                      AppTheme.buttonTextColor, // Using button text color as it matches the theme
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
