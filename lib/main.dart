import 'package:bible_trivia/core/app-theme/inherited_app_theme.dart';
import 'package:bible_trivia/widgets/app_drawer.dart';
import 'package:bible_trivia/widgets/custom_app_bar.dart';
import 'package:bible_trivia/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/authenticate/sign-in/pages/common_login_page.dart';
import 'app/game-levels/pages/game_level_map.dart';
import 'app/quiz/pages/quiz_page.dart';
import 'core/app-theme/app_theme.dart';
import 'core/utility/config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  FirebaseAuth.instance.setLanguageCode('en');

  print("Loading environment variables...");
  print(Config.serverClientId);
  print("Environment variables loaded.");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          titleTextStyle: InheritedAppTheme.appBarTextStyle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppTheme.buttonBackgroundColor),
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
            padding: const EdgeInsets.all(AppTheme.spaceSizeLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTheme.welcomeText,
                  textAlign: TextAlign.center,
                  style: InheritedAppTheme.headerTextStyle,
                ),
                const SizedBox(height: AppTheme.spaceSizeMedium), // Updated
                Text(
                  AppTheme.knowledgeText,
                  style: InheritedAppTheme.bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spaceSizeMedium), // Updated
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
                  buttonText: AppTheme.signInText,
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
