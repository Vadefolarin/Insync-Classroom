// File: lib/screens/widgets/quick_actions.dart

import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Create Quiz Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to Create Quiz Screen
            },
            icon: Icon(Icons.add_circle, size: 28),
            label: Text('Create Quiz', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        // View Quizzes Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to Quizzes List Screen
            },
            icon: Icon(Icons.assignment, size: 28),
            label: Text('View Quizzes', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Different color for distinction
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
