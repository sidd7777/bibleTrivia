import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:bible_trivia/widgets/app_drawer.dart';
import 'package:bible_trivia/widgets/custom_app_bar.dart';
import 'package:bible_trivia/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../animations/slide_page_transition.dart';
import '../../authenticate/sign-in/pages/common_login_page.dart';
import '../../game-levels/pages/game_level_map.dart';
import '../../quiz/pages/quiz_page.dart';

class HomePage extends StatefulWidget {
  final String title; // Store the title

  const HomePage({super.key, required this.title}); // Constructor with title

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.1; // Responsive padding

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        showDrawer: true,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTheme.welcomeText,
                  textAlign: TextAlign.center,
                  style: InheritedAppTheme.headerTextStyle,
                ),
                const SizedBox(height: AppTheme.spaceSizeMedium),
                Text(
                  AppTheme.knowledgeText,
                  style: InheritedAppTheme.bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spaceSizeMedium),
                CustomElevatedButton(
                  buttonText: AppTheme.startQuizText,
                  onPressed: _navigateToQuiz,
                ),
                CustomElevatedButton(
                  buttonText: AppTheme.startGameText,
                  onPressed: _navigateToGameLevelMap,
                ),
                CustomElevatedButton(
                  buttonText: AppTheme.signInText,
                  onPressed: _navigateToLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuiz() async {
    try {
      await Navigator.push(
        context,
        SlidePageTransition(
          page: const QuizPage(),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      // Handle any errors that may occur during navigation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load quiz page')),
      );
    }
  }

  void _navigateToGameLevelMap() async {
    try {
      await Navigator.push(
        context,
        SlidePageTransition(
          page: const GameLevelMap(),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load game level map')),
      );
    }
  }

  void _navigateToLogin() async {
    try {
      await Navigator.push(
        context,
        SlidePageTransition(
          page: const CommonLoginPage(),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load login page')),
      );
    }
  }
}
