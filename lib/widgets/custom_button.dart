import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? backgroundColor; // Optional background color (used for gradient)
  final Color? textColor; // Optional text color
  final Color? borderColor; // Optional border color
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
    this.image, // Allow partial customization
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor ?? Colors.white,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0), // Curved at the ends
        ),
        elevation: 10.0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColor != null
                ? [backgroundColor!, backgroundColor!.withOpacity(0.8)]
                : [Colors.purple, Colors.deepPurpleAccent], // Default gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: borderColor ?? Colors.deepPurpleAccent, // Default border color
          ),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 75,
            minHeight: 50.0,
          ), // Minimum button size
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) // Show icon if provided
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
              if (image != null) // Show image with controlled size if provided
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 36.0,
                    height: 36.0,
                    child: image,
                  ),
                ),
              Flexible(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.white, // Default or custom text color
                  ),
                  textAlign: TextAlign.center, // Ensure the text is centered
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
