import 'package:flutter/material.dart';

class SlidePageTransition extends PageRouteBuilder {
  final Widget page;
  final Duration duration; // Duration for the transition
  final Color backgroundColor; // Background color for the transition

  SlidePageTransition({
    required this.page,
    this.duration = const Duration(seconds: 1),
    this.backgroundColor = Colors.transparent,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            // Define the tween for the slide-in transition
            var tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return Container(
              color: backgroundColor, // Set background color
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: duration, // Use the duration parameter
          reverseTransitionDuration: duration, // Match reverse duration
        );
}
