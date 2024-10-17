import 'package:bible_trivia/app/splash-screen/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app-theme/app_theme.dart';
import 'core/app-theme/inherited_app_theme.dart';
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
      home: const SplashScreen(), // Show splash screen first
    );
  }
}
