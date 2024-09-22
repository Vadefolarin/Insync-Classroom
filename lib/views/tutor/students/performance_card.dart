// File: lib/widgets/overall_performance_card.dart

import 'package:flutter/material.dart';

class OverallPerformanceCard extends StatelessWidget {
  final double averageScore;

  const OverallPerformanceCard({super.key, required this.averageScore});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          children: [
            Text(
              'Overall Student Performance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              averageScore.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Average Score',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
