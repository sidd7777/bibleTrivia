import 'dart:async'; // For Timer

import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../widgets/level_circle.dart';
import '../widgets/path_painter.dart';

class GameLevelMap extends StatefulWidget {
  const GameLevelMap({super.key});

  @override
  GameLevelMapState createState() => GameLevelMapState();
}

class GameLevelMapState extends State<GameLevelMap> {
  static const int levels = 50; // Number of levels
  static const int currentLevel = 1; // Current user level
  static const double baseCanvasHeight = 1500;
  static const double levelHeight = 60;

  final ScrollController _scrollController = ScrollController();
  bool scrolledToCurrentLevel = false; // Flag to prevent multiple scrolls
  bool pathReady = false; // Path ready flag
  bool showLoading = true; // Show loading initially

  @override
  void initState() {
    super.initState();
    _checkPathReady();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // Simulate an async operation to check if paths are ready
  void _checkPathReady() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate delay
    setState(() {
      showLoading = false; // Hide the loading indicator
      pathReady = PathPainter.circleCenters.isNotEmpty; // Ensure path is ready
      _scrollToCurrentLevel(); // Scroll to the current level once ready
    });
  }

  // Scroll to the user's current level (only once)
  void _scrollToCurrentLevel() {
    if (!scrolledToCurrentLevel && PathPainter.circleCenters.isNotEmpty) {
      final double scrollPosition = PathPainter.circleCenters[currentLevel - 1].dy - 200;
      _scrollController
          .animateTo(
        scrollPosition,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      )
          .then((_) {
        setState(() {
          scrolledToCurrentLevel = true; // Prevent future scrolls
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTheme.gameLevelsText),
        backgroundColor: AppTheme.backgroundColor, // Use AppTheme for AppBar
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor, // AppTheme primary color
                Colors.black,
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double canvasHeight =
                  baseCanvasHeight + (levels * levelHeight); // Dynamic height

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
                      if (pathReady && currentLevel - 1 < PathPainter.circleCenters.length)
                        Positioned(
                          left: PathPainter.circleCenters[currentLevel - 1].dx - 65,
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
                              color: AppTheme.iconColor, // Use AppTheme for icon color
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
