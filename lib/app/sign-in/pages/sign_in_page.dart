import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../auth/google/sign_in_with_google.dart';
import '../auth/phone-number/sign_in_with_phone_number.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String phoneNumber = '';
  String smsCode = '';
  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonBackgroundColor,
              ),
              onPressed: () async {
                await signInWithGoogle();
              },
              child: Text(
                'Sign in with Google',
                style: InheritedAppTheme.buttonTextStyle,
              ),
            ),
            TextField(
              onChanged: (value) => phoneNumber = value,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: InheritedAppTheme.bodyTextStyle,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
              ),
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonBackgroundColor,
              ),
              onPressed: () async {
                await signInWithPhoneNumber(phoneNumber);
              },
              child: Text(
                'Send OTP',
                style: InheritedAppTheme.buttonTextStyle,
              ),
            ),
            TextField(
              onChanged: (value) => smsCode = value,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                hintStyle: InheritedAppTheme.bodyTextStyle,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
              ),
            ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonBackgroundColor,
              ),
              onPressed: () async {
                await verifyOtp(verificationId, smsCode);
              },
              child: Text(
                'Verify OTP',
                style: InheritedAppTheme.buttonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
