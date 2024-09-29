// auth_service.dart

import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utility/config.dart';

class AuthService {
  late final String serverClientId; // Declare the serverClientId
  late GoogleSignIn googleSignIn; // Declare the GoogleSignIn instance
  final String backendUrl = "http://11.44.254.48:5000";

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
  Future<http.Response> loginWithEmailPassword(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("$backendUrl/api/login"), // Your backend URL
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
        print('Google sign-in canceled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      // Check if idToken is null
      if (idToken == null) {
        print('Error: No ID Token received');
        return;
      }

      // Print the actual ID token
      print('Google Sign-In successful: ID Token = $idToken');

      var response = await http.post(
        Uri.parse('$backendUrl/api/google-signin'), // Your backend URL
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

  Future<http.Response> signUpWithEmailPassword(String email, String password) async {
    try {
      // Create the request body
      Map<String, String> requestBody = {
        'email': email,
        'password': password,
      };

      // Send POST request to the backend API
      var response = await http.post(
        Uri.parse('$backendUrl/api/register'), // Backend endpoint for user registration
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Handle success or failure
      if (response.statusCode == 200) {
        print('Sign-up successful');
      } else {
        print('Sign-up failed: ${response.body}');
      }
      return response; // Return the response to handle it in the UI
    } catch (error) {
      print('Error during sign-up: $error');
      rethrow; // Rethrow the error to handle it in the UI
    }
  }
}
