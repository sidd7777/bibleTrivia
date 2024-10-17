import 'package:bible_trivia/widgets/custom_error_dialog.dart';
import 'package:bible_trivia/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../homepage/pages/home_page.dart';
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
  final AuthService authService = AuthService();
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Input validation
    if (_validateInputs(email, password)) {
      User? user = await authService.signInWithEmailPassword(
        context,
        email,
        password,
      );
      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              title: AppTheme.appBarTitleText,
            ),
          ),
        );
      } else {
        _showErrorDialog(AppTheme.registrationFailedMessage);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _validateInputs(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(AppTheme.allFieldsRequiredMessage);
      return false;
    }

    // Email format validation
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      _showErrorDialog("Please enter a valid email address.");
      return false;
    }

    // Password validation (e.g., minimum length 6 characters)
    if (password.length < 6) {
      _showErrorDialog("Password must be at least 6 characters long.");
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomErrorDialog(
          content: message,
          onClose: () {
            Navigator.of(context).pop();
          },
          title: AppTheme.errorDialogTitle,
        );
      },
    );
  }

  Future<void> _loginWithFacebook() async {
    setState(() {
      _isFacebookLoading = true;
    });

    User? user = await authService.signInWithFacebook();
    if (user != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: AppTheme.appBarTitleText,
          ),
        ),
      );
    } else {
      _showErrorDialog(AppTheme.facebookSignInFailedMessage);
    }

    setState(() {
      _isFacebookLoading = false;
    });
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    User? user = await authService.signInWithGoogle();
    if (user != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: AppTheme.appBarTitleText,
          ),
        ),
      );
    } else {
      _showErrorDialog(AppTheme.googleSignInFailedMessage);
    }

    setState(() {
      _isGoogleLoading = false;
    });
  }

  void _forgotPassword() {
    // Placeholder for forgot password functionality
    _showErrorDialog("Forgot Password functionality not implemented yet.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTheme.appBarTitleText)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spaceSizeMedium),
          child: Column(
            children: [
              // Card for email and password input
              Card(
                elevation: AppTheme.spaceSizeSmall,
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spaceSizeMedium),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        labelText: AppTheme.emailLabel,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppTheme.spaceSizeMedium),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: AppTheme.passwordLabel,
                        obscureText: !_passwordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: AppTheme.spaceSizeMedium),
                      _isLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: _isLoading ? () {} : _login,
                              buttonText: AppTheme.loginText,
                            ),
                      CustomElevatedButton(
                        buttonText: AppTheme.forgotPasswordText,
                        onPressed: _forgotPassword,
                      ),
                    ],
                  ),
                ),
              ),

              _isGoogleLoading
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      image: Image.asset("assets/images/google.png"),
                      onPressed: _isGoogleLoading ? () {} : _loginWithGoogle,
                      buttonText: AppTheme.googleSignInButtonText,
                    ),

              _isFacebookLoading
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      image: Image.asset("assets/images/facebook.jpeg"),
                      onPressed: _isFacebookLoading ? () {} : _loginWithFacebook,
                      buttonText: AppTheme.facebookSignInButtonText,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppTheme.alreadyHaveAccountText),
                  CustomElevatedButton(
                    onPressed: _isLoading
                        ? () {} // Provide an empty function
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                    buttonText: AppTheme.signUpButtonText, // Use the sign-up redirect text
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
