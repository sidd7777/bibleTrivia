import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../core/app-theme/inherited_app_theme.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_success_dialog.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../auth/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppTheme.forgotPasswordPageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceSizeMedium), // Use AppTheme for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppTheme.forgotPasswordInstructions,
              style: InheritedAppTheme.instructionTextStyle,
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium), // Use AppTheme for spacing

            CustomTextField(
              controller: _emailController,
              labelText: AppTheme.emailLabel,
              errorText: _errorMessage,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium), // Use AppTheme for spacing

            CustomElevatedButton(
              isLoading: _isLoading,
              onPressed: _sendPasswordResetEmail,
              buttonText: AppTheme.sendResetLinkButtonText,
            ),
            if (_errorMessage != null)
              Padding(
                padding:
                    const EdgeInsets.only(top: AppTheme.spaceSizeSmall), // Use AppTheme for padding
                child: CustomText(
                  text: _errorMessage!,
                  style: TextStyle(color: AppTheme.errorColor),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.sendPasswordResetEmail(_emailController.text.trim());
      _showSuccessDialog();
    } catch (e) {
      setState(() {
        _errorMessage = _mapErrorToMessage(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSuccessDialog(
          title: AppTheme.successDialogTitle,
          message: AppTheme.successDialogMessage,
          onClose: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  String _mapErrorToMessage(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-not-found':
          return 'No user found for that email.';
        default:
          return 'An unknown error occurred.';
      }
    }
    return 'Error: ${error.toString()}'; // Dynamic generic error message
  }
}
