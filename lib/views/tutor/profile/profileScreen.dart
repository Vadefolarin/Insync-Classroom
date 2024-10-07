// File: lib/screens/profile_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';
import '../../onboarding/continue_as.dart';
import 'profile_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel _currentUser;
  bool _isLoading = true;
  bool _isUpdating = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _currentUser = UserModel(
      id: '',
      name: '',
      email: '',
      role: '',
      profilePictureUrl: '',
    );
    _fetchUserProfile();
  }

  // Fetch the current user's profile from Firestore
  Future<void> _fetchUserProfile() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        setState(() {
          _currentUser = UserModel.fromDocument(userDoc);
          _isLoading = false;
        });
      } else {
        // Handle user not found
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User profile not found.')),
        );
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to load profile. Please try again.')),
      );
    }
  }

  // Update the user's profile
  Future<void> _updateProfile(
      UserModel updatedUser, File? newProfileImage) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      String uid = _auth.currentUser!.uid;
      String? profilePictureUrl = _currentUser.profilePictureUrl;

      // If a new profile image is selected, upload it to Firebase Storage
      if (newProfileImage != null) {
        Reference storageRef = _storage
            .ref()
            .child('profile_pictures')
            .child(uid)
            .child('profile.jpg');
        UploadTask uploadTask = storageRef.putFile(newProfileImage);
        TaskSnapshot snapshot = await uploadTask;
        profilePictureUrl = await snapshot.ref.getDownloadURL();
      }

      // Update Firestore with the new profile data
      await _firestore.collection('users').doc(uid).update({
        'name': updatedUser.name,
        'profilePictureUrl': profilePictureUrl,
      });

      // If email is changed, update Firebase Auth
      if (updatedUser.email != _currentUser.email) {
        await _auth.currentUser!.updateEmail(updatedUser.email);
      }

      // Refresh the profile data
      _fetchUserProfile();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully.')),
      );
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to update profile. Please try again.')),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  // Change Password
  Future<void> _changePassword(
      String currentPassword, String newPassword) async {
    try {
      setState(() {
        _isUpdating = true;
      });

      User? user = _auth.currentUser;
      String email = user!.email!;

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully.')),
      );
    } on FirebaseAuthException catch (e) {
      print('Error changing password: $e');
      String message = 'Failed to change password.';
      if (e.code == 'wrong-password') {
        message = 'Current password is incorrect.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print('Error changing password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to change password. Please try again.')),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  // Sign Out
  Future<void> _signOut() async {
    // await _auth.signOut();
    // Optionally, navigate to the login screen

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const ContinueAsWidget();
                }));
              },
              child: const Text('Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              title:
                  const Text('Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _signOut,
                  tooltip: 'Sign Out',
                ),
              ],
            ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: () async {
                      // Pick an image
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );

                      if (pickedFile != null) {
                        File imageFile = File(pickedFile.path);
                        // Update the profile picture
                        _updateProfile(
                          UserModel(
                            id: _currentUser.id,
                            name: _currentUser.name,
                            email: _currentUser.email,
                            role: _currentUser.role,
                            profilePictureUrl: _currentUser.profilePictureUrl,
                          ),
                          imageFile,
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(_currentUser.profilePictureUrl),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Profile Form
                  ProfileForm(
                    user: _currentUser,
                    onSave: (updatedUser, newImage) {
                      _updateProfile(updatedUser, newImage);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Change Password Section
                  ElevatedButton(
                    onPressed: () {
                      _showChangePasswordDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Change Password'),
                  ),

                  const SizedBox(height: 24),

                  // Update Loading Indicator
                  _isUpdating
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }

  // Dialog to Change Password
  void _showChangePasswordDialog() {
    String currentPassword = '';
    String newPassword = '';
    String confirmPassword = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Current Password
                TextField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: "Current Password"),
                  onChanged: (value) {
                    currentPassword = value;
                  },
                ),
                // New Password
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "New Password"),
                  onChanged: (value) {
                    newPassword = value;
                  },
                ),
                // Confirm Password
                TextField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: "Confirm New Password"),
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Change"),
              onPressed: () {
                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match.')),
                  );
                  return;
                }

                Navigator.of(context).pop();

                _changePassword(currentPassword, newPassword);
              },
            ),
          ],
        );
      },
    );
  }
}
