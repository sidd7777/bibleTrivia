import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/custom_text_field.dart';
import '../../model/user_model.dart';
import '../profile-controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController();
  UserModel? userProfile;
  bool isEditing = false;

  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _profilePhoto;
  String? profilePhotoUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();

    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
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
        profilePhotoUrl = userProfile!.photoURL;
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
        if (profilePhotoUrl != null) {
          profilePhotoUrl = await _profileController.uploadImage(_profilePhoto!);
        }
        await _profileController.updateUserProfile(
          userProfile!,
          _usernameController,
          _nameController,
          _emailController,
          _mobileController,
          profilePhotoUrl,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        }
        _toggleEdit();
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
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Discard changes?'),
              content: Text('You have unsaved changes. Are you sure you want to leave?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Stay on the page
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Discard changes
                  child: Text('Discard'),
                ),
              ],
            ),
          ) ??
          false;
    }
    return true; // Close the screen if not in edit mode
  }

  Future<void> _pickProfilePhoto() async {
    if (isEditing) {
      _profilePhoto = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {});
    }
  }

  void _showEditSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please use the edit button to edit the fields')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userProfile == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: GestureDetector(
        onTap: () {
          if (!isEditing) {
            _showEditSnackBar();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: isEditing ? _pickProfilePhoto : _showEditSnackBar,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _profilePhoto != null
                      ? FileImage(File(_profilePhoto!.path))
                      : (profilePhotoUrl != null
                          ? NetworkImage(profilePhotoUrl!)
                          : AssetImage('assets/images/default.png')),
                  child: _profilePhoto == null && profilePhotoUrl == null
                      ? Icon(
                          Icons.camera_alt_sharp,
                          size: 50,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _usernameController,
                labelText: 'Username',
                obscureText: false,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _nameController,
                labelText: 'Display Name',
                obscureText: false,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _mobileController,
                labelText: 'Mobile Number',
                keyboardType: TextInputType.phone,
                obscureText: false,
                readOnly: !isEditing,
              ),
              Spacer(),
              WillPopScope(
                onWillPop: _onWillPop,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEditing ? _updateUserProfile : _toggleEdit,
        backgroundColor: Colors.purple,
        child: Icon(isEditing ? Icons.save : Icons.edit),
      ),
    );
  }
}
