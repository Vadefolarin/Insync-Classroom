// File: lib/widgets/profile_form.dart

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

class ProfileForm extends StatefulWidget {
  final UserModel user;
  final Function(UserModel updatedUser, File? newImage) onSave;

  ProfileForm({required this.user, required this.onSave});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  File? _newImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    // Image picking handled in the ProfileScreen
  }

  void _submit() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name and email cannot be empty.')),
      );
      return;
    }

    // Create updated user model
    UserModel updatedUser = UserModel(
      id: widget.user.id,
      name: name,
      email: email,
      role: widget.user.role,
      profilePictureUrl: widget.user.profilePictureUrl,
    );

    // Call the onSave callback
    widget.onSave(updatedUser, _newImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        // Name Field
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 16),
        // Email Field
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 24),
        // Save Button
        ElevatedButton(
          onPressed: _submit,
          child: Text('Save Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
