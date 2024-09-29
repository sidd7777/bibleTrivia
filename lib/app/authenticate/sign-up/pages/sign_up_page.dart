import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../main.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../auth/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService(); // Instance of AuthService

  void _handleSignUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      var response = await authService.signUpWithEmailPassword(email, password);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['token'];
        print('Sign up successful: $token');
        // Navigate to the home page or another screen
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(
                title: AppTheme.appBarTitleText,
              ),
            ),
          );
        }
      } else {
        print('Sign up failed: ${response.body}');
      }
    } catch (e) {
      print('Error during sign up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTheme.signUpTitle)), // e.g., "Sign Up"
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceSizeMedium),
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
                isPassword: true,
              ),
              CustomElevatedButton(
                buttonText: AppTheme.signUpButtonText, // "Sign Up"
                onPressed: _handleSignUp,
                backgroundColor: Colors.purple[300],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
