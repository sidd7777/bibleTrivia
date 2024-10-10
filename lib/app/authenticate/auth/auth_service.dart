import 'package:bcrypt/bcrypt.dart';
import 'package:bible_trivia/widgets/custom_error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Register user using email and password
  Future<User?> registerWithEmailPassword(BuildContext context, String name, String email,
      String password, String username, String? mobileNumber) async {
    try {
      print('Registering user: $username with email: $email');

      // Hash the password before storing
      String hashedPassword = _hashPassword(password);
      print('Hashed password generated.');

      // Create user with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password, // Use plain password for registration
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(username);
        print('User created successfully: ${user.uid}');

        // Create UserModel and save it in Firestore
        await _createUserInFirestore(
          user: user,
          username: username,
          email: email,
          hashedPassword: hashedPassword,
          mobileNumber: mobileNumber,
        );

        return user;
      } else {
        print('User creation failed: User is null.');
      }
    } catch (e) {
      print('Registration error: $e');
      _handleError(context, 'Registration Error', e);
    }
    return null;
  }

  /// Sign-in with email and password
  Future<User?> signInWithEmailPassword(BuildContext context, String email, String password) async {
    try {
      print('Signing in user with email: $email');
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in successfully: ${userCredential.user?.uid}');
      return userCredential.user;
    } catch (e) {
      print('Login error: $e');
      _handleError(context, 'Login Error', e);
    }
    return null;
  }

  /// Google Sign-in
  Future<User?> signInWithGoogle() async {
    try {
      print('Initiating Google Sign-In...');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Google Sign-In was cancelled by the user.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Google authentication failed');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      print('User signed in with Google: ${user?.uid}');

      if (user != null) {
        // Check if user exists in Firestore and create if not
        await _checkAndCreateUserInFirestore(user, 'Google User');
      }
      return user;
    } catch (e) {
      print('Google Sign-In failed: $e');
      throw Exception('Google Sign-In failed: $e');
    }
  }

  /// Facebook Sign-in
  Future<User?> signInWithFacebook() async {
    try {
      print('Initiating Facebook Sign-In...');
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;
        print('User signed in with Facebook: ${user?.uid}');

        if (user != null) {
          // Check if user exists in Firestore and create if not
          await _checkAndCreateUserInFirestore(user, 'Facebook User');
        }
        return user;
      } else {
        throw Exception('Facebook login failed: ${result.status}');
      }
    } catch (e) {
      print('Facebook login failed: $e');
      throw Exception('Facebook login failed: $e');
    }
  }

  /// Helper function to create user in Firestore if it doesn't exist
  Future<void> _checkAndCreateUserInFirestore(User user, String defaultUsername) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      UserModel newUser = UserModel(
        name: user.displayName ?? '',
        userId: user.uid,
        username: defaultUsername, // Default username for social logins
        email: user.email ?? '',
        password: '', // No password for social logins
        mobileNumber: user.phoneNumber ?? '',
        createdAt: DateTime.now(),
        lastRechargeTime: DateTime.now(),
      );

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(newUser.toMap());
      print('New user data created in Firestore for user: ${user.uid}');
    } else {
      print('User already exists in Firestore: ${user.uid}');
    }
  }

  /// Helper function to create user in Firestore during registration
  Future<void> _createUserInFirestore({
    required User user,
    required String username,
    required String email,
    required String hashedPassword,
    String? mobileNumber,
  }) async {
    UserModel newUser = UserModel(
      name: user.displayName ?? '',
      userId: user.uid,
      username: username,
      email: email,
      password: hashedPassword,
      mobileNumber: mobileNumber,
      createdAt: DateTime.now(),
      lastRechargeTime: DateTime.now(),
    );

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(newUser.toMap());
    print('User data stored in Firestore for user: ${user.uid}');
  }

  /// Password hashing
  String _hashPassword(String password) {
    print('Hashing password...');
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Error handling function
  void _handleError(BuildContext context, String title, Object e) {
    print('Error occurred: $e');
    String errorMessage = _getFirebaseErrorMessage(e);
    showDialog(
      context: context,
      builder: (context) => CustomErrorDialog(
        title: title,
        content: errorMessage,
        onClose: () {
          Navigator.of(context).pop();
        },
      ),
    ); // Assuming show method is available in CustomErrorDialog
  }

  /// Error message mapping
  String _getFirebaseErrorMessage(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'email-already-in-use':
          return 'The email is already in use.';
        default:
          return 'An unknown error occurred.';
      }
    }
    return e.toString();
  }
}
