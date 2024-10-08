import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../onboarding/continue_as.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String teacherName = "Dr Obe";
  String teacherEmail = "john.doe@example.com";
  String teacherSubject = "Mathematics";
  String teacherPhone = "123-456-7890";
  String teacherImageUrl = ""; // This will be fetched from Firebase

  // Method to pick an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Here you can upload the image to Firebase Storage and update Firestore with the new image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile image section
            Center(
              child: Stack(
                children: [
                  // Display the profile image
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : teacherImageUrl.isNotEmpty
                            ? NetworkImage(teacherImageUrl) as ImageProvider
                            : const AssetImage(
                                'assets/images/account_header.png'),
                    backgroundColor: Colors.grey[200],
                  ),
                  // Edit icon
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showImagePickerOptions(context);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 20,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Teacher Information
            _buildInfoTile('Name', teacherName),
            const SizedBox(height: 10),
            _buildInfoTile('Email', teacherEmail),
            const SizedBox(height: 10),

            _buildInfoTile('Department', teacherSubject),
            const SizedBox(height: 10),

            _buildInfoTile('Phone', teacherPhone),

            const SizedBox(height: 20),

            // Log out button
            ElevatedButton.icon(
              onPressed: () async {
                // Log out from Firebase
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
                            await FirebaseAuth.instance.signOut();
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
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            // Save button (if needed)
            ElevatedButton.icon(
              onPressed: () {
                // Save updated image to Firestore or any changes
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show options for image picker (Gallery/Camera)
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 120,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('Choose Profile Image',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt,
                          size: 40, color: Colors.deepPurple),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_library,
                          size: 40, color: Colors.deepPurple),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  // Build a reusable info tile for teacher details
  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      leading: Icon(
        title == 'Name'
            ? Icons.person
            : title == 'Email'
                ? Icons.email
                : title == 'Subject'
                    ? Icons.book
                    : Icons.phone, // Default for Phone
        color: Colors.deepPurple,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.deepPurple.withOpacity(0.5)),
      ),
    );
  }
}
