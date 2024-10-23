// profile_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class ProfileController {
  // Fetch user profile from Firebase
  Future<UserModel?> fetchUserProfile() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      return UserModel.fromMap(userDoc.data()!);
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  // Update user profile to Firebase
  Future<void> updateUserProfile(
      UserModel userProfile,
      TextEditingController usernameController,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController mobileController) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userProfile.userId).update({
        'username': usernameController.text,
        'name': nameController.text,
        'email': emailController.text,
        'mobileNumber': mobileController.text.isNotEmpty ? mobileController.text : null,
      });
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Failed to update profile');
    }
  }
}
