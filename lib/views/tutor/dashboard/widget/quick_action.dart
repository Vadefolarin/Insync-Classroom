// File: lib/screens/widgets/quick_actions.dart

import 'package:flutter/material.dart';

import '../../quizzes/newQuiz.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

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
 showDialog(
            context: context,
            builder: (context) => const AlertDialog.adaptive(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(0),
              content: NewQuiz(
              
              ),
            ),
          );            },
            icon: const Icon(Icons.add_circle, size: 28),
            label: const Text('Create Quiz', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // View Quizzes Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to Quizzes List Screen
            },
            icon: const Icon(Icons.assignment, size: 28),
            label: const Text('View Quizzes', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Different color for distinction
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
