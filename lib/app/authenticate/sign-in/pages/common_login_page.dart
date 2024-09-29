import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../main.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../auth/auth_service.dart';
import '../../sign-up/pages/sign_up_page.dart';

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
        String token = jsonResponse['token'];
        print('Email login successful: $token');
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
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTheme.loginTitle)),
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
                image: Image.asset('assets/images/google.png'),
                buttonText: AppTheme.googleSignInButton,
                onPressed: _handleGoogleLogin,
                backgroundColor: Colors.purple[200],
                textColor: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppTheme.dontHaveAccountText), // "Don't have an account?"
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(AppTheme.createAccountText), // "Create an account"
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
