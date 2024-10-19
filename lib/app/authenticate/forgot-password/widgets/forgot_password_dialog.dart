import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/app-theme/app_theme.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_error_dialog.dart';
import '../../../../widgets/custom_text_field.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final VoidCallback onClose;

  const ForgotPasswordDialog({super.key, required this.onClose});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showErrorDialog(AppTheme.emptyEmailError); // Dynamic error message
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _showSuccessDialog(AppTheme.passwordResetEmailSent); // Dynamic success message
    } catch (error) {
      _showErrorDialog(AppTheme.passwordResetEmailFailed); // Dynamic error message
    }

    setState(() {
      _isLoading = false;
    });
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomErrorDialog(
          content: message,
          onClose: widget.onClose,
          title: AppTheme.successDialogTitle, // Dynamic title from AppTheme
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppTheme.forgotPasswordText), // Dynamic title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: _emailController,
            labelText: AppTheme.emailLabel, // Use AppTheme for email label
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppTheme.spaceSizeMedium), // Use AppTheme for spacing
          _isLoading
              ? CircularProgressIndicator()
              : CustomElevatedButton(
                  buttonText: AppTheme.sendResetLinkButtonText, // Dynamic button text
                  onPressed: _sendPasswordResetEmail,
                ),
        ],
      ),
    );
  }
}
