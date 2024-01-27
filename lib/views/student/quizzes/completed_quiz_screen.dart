import 'package:flutter/material.dart';

class CompletedQuizScreen extends StatelessWidget {
  const CompletedQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          SizedBox(height: 16),
          Text(
            'Quiz Completed Successfully!',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
