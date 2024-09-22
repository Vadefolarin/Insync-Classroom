// File: lib/screens/widgets/welcome_header.dart

import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String teacherName;
  final String profileImageUrl;

  WelcomeHeader({required this.teacherName, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Greeting Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $teacherName!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '${DateTime.now().toLocal()}'.split(' ')[0], // Current date
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        // Profile Picture
        GestureDetector(
          onTap: () {
            // Navigate to Profile Screen
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
        ),
      ],
    );
  }
}
