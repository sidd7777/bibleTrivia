import 'dart:async'; // For Timer

import 'package:flutter/material.dart';

import '../widgets/level_circle.dart';
import '../widgets/path_painter.dart';

class GameLevelMap extends StatefulWidget {
  const GameLevelMap({super.key});

  @override
  GameLevelMapState createState() => GameLevelMapState();
}

class GameLevelMapState extends State<GameLevelMap> {
  final int levels = 50; // Number of levels
  final int currentLevel = 22; // Current user level
  final ScrollController _scrollController = ScrollController();
  bool scrolledToCurrentLevel = false;
  bool pathReady = false; // Path ready flag
  bool showLoading = true; // Show loading initially

  @override
  void initState() {
    super.initState();

    // Start a timer to show the CircularProgressIndicator for 3 seconds
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        showLoading = false; // After 3 seconds, hide the loading indicator
        pathReady =
            PathPainter.circleCenters.isNotEmpty; // Ensure path is ready
        _scrollToCurrentLevel(); // Scroll to the current level once ready
      });
    });
  }

  // Scroll to the user's current level (only once)
  void _scrollToCurrentLevel() {
    if (!scrolledToCurrentLevel && PathPainter.circleCenters.isNotEmpty) {
      final double scrollPosition =
          PathPainter.circleCenters[currentLevel - 1].dy - 200;
      _scrollController
          .animateTo(
        scrollPosition,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      )
          .then((_) {
        scrolledToCurrentLevel = true; // Prevent future scrolls
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Levels'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: // Show loading for 3 seconds

            Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.black], // Gradient colors
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double canvasHeight =
                  1500 + (levels * 60); // Dynamic height

              return SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  height: canvasHeight,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(constraints.maxWidth, canvasHeight),
                        painter: PathPainter(levels),
                      ),
                      Builder(
                        builder: (context) {
                          final circleCenters = PathPainter.circleCenters;

                          // Ensure circleCenters has values before using them
                          if (circleCenters.isEmpty) {
                            return const SizedBox(); // Empty widget if no centers
                          }

                          return Stack(
                            children: List.generate(levels, (index) {
                              if (index < circleCenters.length) {
                                final center = circleCenters[index];
                                return Positioned(
                                  left: center.dx - 25,
                                  top: center.dy - 25,
                                  child: LevelCircle(
                                    index: index + 1,
                                    onTap: () {
                                      print('Tapped on level ${index + 1}');
                                    },
                                  ),
                                );
                              } else {
                                return Container(); // Empty container for safety
                              }
                            }),
                          );
                        },
                      ),
                      // Display user icon at the current level (if circleCenters is available)
                      if (PathPainter.circleCenters.isNotEmpty &&
                          currentLevel - 1 < PathPainter.circleCenters.length)
                        Positioned(
                          left: PathPainter.circleCenters[currentLevel - 1].dx -
                              65,
                          top: PathPainter.circleCenters[currentLevel - 1].dy -
                              65, // Adjust the vertical position so it's on top
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black, // Black background
                            ),
                            child: const Icon(
                              Icons.account_circle_rounded, // User icon
                              size: 50,
                              color: Colors.orange, // User icon color
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
