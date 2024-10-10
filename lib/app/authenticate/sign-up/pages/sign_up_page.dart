import 'package:bible_trivia/app/authenticate/sign-in/pages/common_login_page.dart';
import 'package:bible_trivia/core/app-theme/app_theme.dart';
import 'package:bible_trivia/widgets/custom_button.dart';
import 'package:bible_trivia/widgets/custom_error_dialog.dart';
import 'package:bible_trivia/widgets/custom_text.dart'; // Import CustomText
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _mobileController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _register() async {
    setState(() {});

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final username = _usernameController.text.trim();
    final mobileNumber = _mobileController.text.trim();
    final name = _nameController.text.trim();

    // Validate input fields
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        username.isEmpty ||
        mobileNumber.isEmpty ||
        name.isEmpty) {
      _showErrorDialog('Empty Fields', 'Please fill all fields.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Password Mismatch', 'The passwords do not match.');
      return;
    }

    try {
      User? user = await authService.registerWithEmailPassword(
          context, name, email, password, username, mobileNumber);
      if (user != null) {
        print('User registered successfully: ${user.uid}');
        // Use pushReplacement to navigate to HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(
              title: AppTheme.appBarTitleText,
            ),
          ),
        );
      }
    } catch (e) {
      print('Registration error: $e');
      _showErrorDialog(
          'Registration Error', e.toString()); // Show error message if registration fails
    } finally {
      setState(() {});
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => CustomErrorDialog(
        title: title,
        content: content,
        onClose: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: AppTheme.signUpTitle,
              color: AppTheme.primaryColor,
              fontSize: AppTheme.fontSizeLargeTitle,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _nameController,
              labelText: AppTheme.nameLabel,
              prefixIcon: Icon(Icons.person), // Add prefix icon
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _usernameController,
              labelText: AppTheme.usernameLabel,
              prefixIcon: Icon(Icons.person_outline), // Add prefix icon
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _emailController,
              labelText: AppTheme.emailLabel,
              prefixIcon: Icon(Icons.email), // Add prefix icon
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _mobileController,
              labelText: AppTheme.mobileNumberLabel,
              prefixIcon: Icon(Icons.phone), // Add prefix icon
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _passwordController,
              labelText: AppTheme.passwordLabel,
              prefixIcon: Icon(Icons.lock),
              obscureText: !_passwordVisible,
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomTextField(
              controller: _confirmPasswordController,
              labelText: AppTheme.confirmPasswordLabel,
              prefixIcon: Icon(Icons.lock),
              obscureText: !_confirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            CustomElevatedButton(
              onPressed: _register,
              buttonText: AppTheme.signUpButtonText,
              backgroundColor: AppTheme.primaryColor,
              textColor: Colors.white, // Change text color to contrast with the button
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: AppTheme.alreadyHaveAccountText,
                  color: AppTheme.primaryColor,
                ),
                CustomElevatedButton(
                  buttonText: AppTheme.loginText,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const CommonLoginPage(),
                      ),
                    );
                  },
                  textColor: AppTheme.primaryColor,
                  backgroundColor: Colors.transparent, // Use the desired background color
                  borderColor: AppTheme.primaryColor, // Use the desired border color
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
