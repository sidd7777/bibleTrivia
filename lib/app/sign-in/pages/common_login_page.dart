// login_page.dart

import 'dart:convert';

import 'package:bible_trivia/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../main.dart';
import '../../../widgets/custom_text_field.dart';
import '../auth/auth_service.dart';

class CommonLoginPage extends StatefulWidget {
  const CommonLoginPage({super.key});

  @override
  State<CommonLoginPage> createState() => _CommonLoginPageState();
}

class _CommonLoginPageState extends State<CommonLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService(); // Instance of AuthService

  void _handleEmailPasswordLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      var response = await authService.loginWithEmailPassword(email, password);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['token']; // Example of using jsonResponse
        print('Email login successful: $token');
        // Navigate to the home page or another screen
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: ""),
            ),
          );
        }
      } else {
        print('Email login failed: ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  void _handleGoogleLogin() async {
    try {
      print('Attempting Google Sign-In...');
      await authService.loginWithGoogle();
      print('Google Sign-In successful');
      // Handle successful login
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
    // Handle the next action (e.g., navigation to the home screen)
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: ""),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTheme.loginTitle)),
      body: Padding(
        padding:
            const EdgeInsets.all(AppTheme.spaceSizeMedium), // Use theme spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: AppTheme.emailLabel,
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: AppTheme.passwordLabel,
              isPassword: true, // Set this to true to obscure the password
            ),
            CustomElevatedButton(
              buttonText: AppTheme.loginWithEmailButton,
              onPressed: _handleEmailPasswordLogin,
            ),
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(AppTheme.orText),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            CustomElevatedButton(
              buttonText: AppTheme.googleSignInButton,
              onPressed: _handleGoogleLogin,
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
