// profile_controller.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';

class ProfileController {
  // Fetch user profile from Firebase
  final FirebaseStorage _storage = FirebaseStorage.instance;
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
    TextEditingController mobileController,
    String? imageUrl,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userProfile.userId).update({
        'username': usernameController.text,
        'name': nameController.text,
        'email': emailController.text,
        'mobileNumber': mobileController.text.isNotEmpty ? mobileController.text : null,
        'photoURL': imageUrl ?? '',
      });
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Failed to update profile');
    }
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final ref = _storage.ref().child('profile_pictures/${image.name}');
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    } // Return null if the upload fails}
  }
}
