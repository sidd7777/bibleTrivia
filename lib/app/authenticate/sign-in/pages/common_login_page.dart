import 'package:bible_trivia/app/welcome/pages/welcome_screen.dart';
import 'package:bible_trivia/widgets/custom_error_dialog.dart';
import 'package:bible_trivia/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../homepage/pages/home_page.dart';
import '../../../model/user_model.dart';
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
        print("User : $user");
        if (user != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful!")),
          );
          _navigateToWelcomeScreen(user);
        } else {
          _showErrorDialog(AppTheme.registrationFailedMessage);
        }
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            _showErrorDialog("No user found for that email.");
            break;
          case 'wrong-password':
            _showErrorDialog("Incorrect password.");
            break;
          default:
            _showErrorDialog("Login failed: ${e.message}");
        }
      } catch (e) {
        _showErrorDialog("An unexpected error occurred: ${e.toString()}");
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
      print("User : $user");
      if (user != null && mounted) {
        _navigateToWelcomeScreen(user);
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
      print("User : $user");
      if (user != null && mounted) {
        _navigateToWelcomeScreen(user);
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

  void _navigateToWelcomeScreen(User user) async {
    bool hasSeenWelcomeScreen = await UserModel.checkWelcomeScreenSeen(user);

    if (!hasSeenWelcomeScreen && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(
            userId: user.uid,
          ), // Pass user if needed
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: AppTheme.appBarTitleText,
          ), // Replace HomePage with your home screen widget
        ),
      );
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

  // Method to build Google login button
  Widget _buildGoogleButton() {
    return _isGoogleLoading
        ? CircularProgressIndicator()
        : CustomElevatedButton(
            image: Image.asset("assets/images/google.png"),
            onPressed: _isGoogleLoading
                ? () {}
                : () async {
                    await _loginWithGoogle(); // Wrap in an anonymous function
                  },
            buttonText: AppTheme.googleSignInButtonText,
          );
  }

  // Method to build Facebook login button
  Widget _buildFacebookButton() {
    return _isFacebookLoading
        ? CircularProgressIndicator()
        : CustomElevatedButton(
            image: Image.asset("assets/images/facebook.jpeg"),
            onPressed: _isFacebookLoading
                ? () {}
                : () async {
                    await _loginWithFacebook(); // Wrap in an anonymous function
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
                elevation: AppTheme.spaceSizeMedium,
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spaceSizeMedium),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        labelText: AppTheme.emailLabel,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
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
                        errorText: _passwordError,
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
              SizedBox(height: AppTheme.spaceSizeMedium),
              _buildGoogleButton(),
              SizedBox(height: AppTheme.spaceSizeMedium),
              _buildFacebookButton(),
              SizedBox(height: AppTheme.spaceSizeMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppTheme.alreadyHaveAccountText),
                  CustomElevatedButton(
                    onPressed: _isLoading
                        ? () {}
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                    buttonText: AppTheme.signUpButtonText,
                    isLoading: _isLoading,
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
