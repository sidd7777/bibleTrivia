import 'package:flutter/material.dart';

class LevelCircle extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  final Color? circleColor; // Optional color for the circle
  final double size; // Custom size for the circle
  final Color textColor; // Color for the text
  final TextStyle? textStyle; // Custom text style

  const LevelCircle({
    required this.index,
    required this.onTap,
    this.circleColor,
    this.size = 50.0, // Default size
    this.textColor = Colors.white, // Default text color
    this.textStyle, // Custom text style
    super.key,
  });

  @override
  LevelCircleState createState() => LevelCircleState();
}

class LevelCircleState extends State<LevelCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onTap(); // Call the passed onTap callback
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _animation,
        child: Material(
          elevation: 4, // Adding elevation for material effect
          shape: CircleBorder(),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.circleColor ?? Colors.blue, // Use dynamic color
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                '${widget.index}',
                style: widget.textStyle ??
                    TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
