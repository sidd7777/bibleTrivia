import 'package:bible_trivia/app/sign-in/pages/common_login_page.dart';
import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:bible_trivia/widgets/app_drawer.dart';
import 'package:bible_trivia/widgets/custom_app_bar.dart';
import 'package:bible_trivia/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'app/game-levels/pages/game_level_map.dart';
import 'app/quiz/pages/quiz_page.dart';
import 'core/app-theme/app_theme.dart';
import 'core/utility/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Loading environment variables...");
  print(Config.serverClientId);
  print("Environment variables loaded.");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          titleTextStyle: TextStyle(
            color: AppTheme.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(AppTheme.buttonBackgroundColor),
            foregroundColor: WidgetStateProperty.all(AppTheme.buttonTextColor),
          ),
        ),
      ),
      home: const MyHomePage(
        title: AppTheme.appBarTitleText,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        showDrawer: true,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTheme.welcomeText,
                  textAlign: TextAlign.center,
                  style: InheritedAppTheme.headerTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  AppTheme.knowledgeText,
                  style: InheritedAppTheme.bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomElevatedButton(
                  buttonText: AppTheme.startQuizText,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                CustomElevatedButton(
                  buttonText: AppTheme.startGameText,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameLevelMap(),
                      ),
                    );
                  },
                ),
                CustomElevatedButton(
                  buttonText: "Sign in Page",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommonLoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
