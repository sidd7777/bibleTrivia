import 'package:bible_trivia/widgets/custom_error_dialog.dart';
import 'package:bible_trivia/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../homepage/pages/home_page.dart';
import '../../auth/auth_service.dart';
import '../../forgot-password/widgets/forgot_password_dialog.dart';
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
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_validateInputs(email, password)) {
      try {
        User? user = await authService.signInWithEmailPassword(context, email, password);
        if (user != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful!")),
          );
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
      } catch (e) {
        _showErrorDialog("An error occurred: ${e.toString()}");
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _validateInputs(String email, String password) {
    bool isValid = true;

    if (email.isEmpty) {
      _emailError = "Please enter your email.";
      isValid = false;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      _emailError = "Please enter a valid email address.";
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordError = "Please enter your password.";
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = "Password must be at least 6 characters long.";
      isValid = false;
    }

    setState(() {}); // Update state to reflect error messages
    return isValid;
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

    try {
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
    } catch (e) {
      _showErrorDialog("Facebook login failed: ${e.toString()}");
    } finally {
      setState(() {
        _isFacebookLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
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
    } catch (e) {
      _showErrorDialog("Google login failed: ${e.toString()}");
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ForgotPasswordDialog(
          onClose: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // New method to build Google login button
  Widget _buildGoogleButton() {
    return _isGoogleLoading
        ? CircularProgressIndicator()
        : CustomElevatedButton(
            image: Image.asset("assets/images/google.png"),
            onPressed: () {
              _isGoogleLoading ? null : _loginWithGoogle();
            },
            buttonText: AppTheme.googleSignInButtonText,
          );
  }

  // New method to build Facebook login button
  Widget _buildFacebookButton() {
    return _isFacebookLoading
        ? CircularProgressIndicator()
        : CustomElevatedButton(
            image: Image.asset("assets/images/facebook.jpeg"),
            onPressed: () {
              _isFacebookLoading ? null : _loginWithFacebook();
            },
            buttonText: AppTheme.facebookSignInButtonText,
          );
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
                        errorText: _emailError, // Display error for email
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
                        errorText: _passwordError, // Display error for password
                      ),
                      SizedBox(height: AppTheme.spaceSizeMedium),
                      _isLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: () {
                                _isLoading ? null : _login();
                              },
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
              SizedBox(height: AppTheme.spaceSizeMedium), // Spacing between card and buttons
              _buildGoogleButton(),
              SizedBox(height: AppTheme.spaceSizeMedium), // Spacing between buttons
              _buildFacebookButton(),
              SizedBox(height: AppTheme.spaceSizeMedium), // Additional spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppTheme.alreadyHaveAccountText),
                  CustomElevatedButton(
                    onPressed: _isLoading
                        ? () {} // No-op function to disable action when loading
                        : () {
                            // If _isLoading is false, navigate to the SignUpPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                    buttonText: AppTheme.signUpButtonText,
                    isLoading: _isLoading, // Pass the loading state to the button
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
