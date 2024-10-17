import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../../homepage/pages/home_page.dart';

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

    // Animation controller for fade-in and fade-out
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
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
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(title: AppTheme.appBarTitleText),
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
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/flutter_new_logo.png', // Replace with your app logo path
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: AppTheme.spaceSizeMedium),
              Text(
                'Bible Trivia',
                style: InheritedAppTheme.headerTextStyle.copyWith(
                  color: AppTheme.buttonTextColor,
                ),
              ),
              const SizedBox(height: AppTheme.spaceSizeMedium),
              const CircularProgressIndicator(), // Loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
