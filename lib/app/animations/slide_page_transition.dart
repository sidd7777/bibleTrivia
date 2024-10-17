import 'package:flutter/material.dart';

class SlidePageTransition extends PageRouteBuilder {
  final Widget page;
  final Duration duration; // Duration for the transition

  SlidePageTransition({required this.page, this.duration = const Duration(seconds: 1)})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide-in transition
            const begin = Offset(1.0, 0.0); // Slide in from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            // Define the tween for the slide-in transition
            var tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            // Slide-out transition for the previous page
            var reverseTween =
                Tween<Offset>(begin: end, end: begin).chain(CurveTween(curve: curve));
            var reverseOffsetAnimation = secondaryAnimation.drive(reverseTween);

            return SlideTransition(
              position: offsetAnimation,
              child: SlideTransition(
                position: reverseOffsetAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: duration, // Use the duration parameter
        );
}
