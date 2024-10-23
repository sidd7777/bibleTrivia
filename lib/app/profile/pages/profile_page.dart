import 'package:flutter/material.dart';

import '../../../widgets/custom_text_field.dart';
import '../../model/user_model.dart';
import '../profile-controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController(); // Instantiate the controller
  UserModel? userProfile;
  bool isEditing = false; // Track whether we are in edit mode

  // Controllers for text fields
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();

    // Initialize controllers
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserProfile() async {
    UserModel? profile = await _profileController.fetchUserProfile();
    if (profile != null) {
      setState(() {
        userProfile = profile;
        _usernameController.text = userProfile!.username;
        _nameController.text = userProfile!.name;
        _emailController.text = userProfile!.email;
        _mobileController.text = userProfile!.mobileNumber ?? '';
      });
    }
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _updateUserProfile() async {
    if (userProfile != null) {
      try {
        await _profileController.updateUserProfile(
          userProfile!,
          _usernameController,
          _nameController,
          _emailController,
          _mobileController,
        );

        // Show a success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        }
        _toggleEdit(); // Exit edit mode
      } catch (e) {
        print('Error updating user profile: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile')),
          );
        }
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (isEditing) {
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Unsaved Changes'),
            content: Text('You have unsaved changes. Would you like to save them before leaving?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Save and exit
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Exit without saving
                child: Text('Discard'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(null), // Cancel the action
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );

      // If the user chooses to save, call the update function
      if (shouldSave == true) {
        await _updateUserProfile();
        return true; // Allow exit after saving
      } else if (shouldSave == false) {
        return true; // Allow exit without saving
      }
      return false; // Cancel the exit
    }
    return true; // Allow exit if not editing
  }

  @override
  Widget build(BuildContext context) {
    if (userProfile == null) {
      return Center(
          child: CircularProgressIndicator()); // Loading indicator while fetching user data
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple, // Your app theme color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _usernameController,
              labelText: 'Username',
              obscureText: false,
              onChanged: (value) {
                userProfile!.username = value; // Update userProfile
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _nameController,
              labelText: 'Display Name',
              obscureText: false,
              onChanged: (value) {
                userProfile!.name = value; // Update userProfile
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              onChanged: (value) {
                userProfile!.email = value; // Update userProfile
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _mobileController,
              labelText: 'Mobile Number',
              keyboardType: TextInputType.phone,
              obscureText: false,
              onChanged: (value) {
                userProfile!.mobileNumber = value.isNotEmpty ? value : null; // Update userProfile
              },
            ),
            Spacer(),
            // Disable the navigation back button while editing
            WillPopScope(
              onWillPop: _onWillPop, // Handle back navigation
              child: Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEditing ? _updateUserProfile : _toggleEdit,
        backgroundColor: Colors.purple, // Your app theme color
        child: Icon(isEditing ? Icons.save : Icons.edit), // Change icon based on editing state
      ),
    );
  }
}
