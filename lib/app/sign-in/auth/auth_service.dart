// auth_service.dart

import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utility/config.dart';

class AuthService {
  late final String serverClientId; // Declare the serverClientId
  late GoogleSignIn googleSignIn; // Declare the GoogleSignIn instance

  AuthService() {
    serverClientId = Config.serverClientId;
    googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
      serverClientId: serverClientId,
    );
  }

  // Email/Password login logic
  Future<http.Response> loginWithEmailPassword(
      String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('http://11.42.13.145:5000/api/login'), // Your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return response;
    } catch (e) {
      print('Email login error: $e');
      throw Exception('Failed to login');
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final idToken = googleAuth.idToken;

      // Check if idToken is null
      if (idToken == null) {
        print('Error: No ID Token received');
        return;
      }

      var response = await http.post(
        Uri.parse(
            'http://11.42.13.145:5000/api/google-signin'), // Your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}), // Ensure the key is 'token'
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        await _saveToken(jsonResponse['token']);
        print('Google login successful');
      } else {
        print('Google login failed: ${response.body}');
      }
    } catch (error) {
      print('Google login error: $error');
    }
  }

  // Save JWT token
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }
}
