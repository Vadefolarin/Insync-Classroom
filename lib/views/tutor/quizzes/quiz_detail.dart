// File: lib/screens/quiz_details_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/quiz_model.dart';

class QuizDetailsScreen extends StatelessWidget {
  final Quiz quiz;

  QuizDetailsScreen({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz Description
            Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              quiz.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Quiz Deadline
            Text(
              'Deadline',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().add_jm().format(quiz.deadline),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Questions
            Text(
              'Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                final question = quiz.questions[index];
                return QuestionCard(
                  question: question,
                  questionNumber: index + 1,
                );
              },
            ),
            SizedBox(height: 24),

            // Created At
            Text(
              'Created At',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().add_jm().format(quiz.createdAt),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;

  QuestionCard({required this.question, required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Text
            Text(
              'Q$questionNumber: ${question.questionText}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            // Options
            Column(
              children: question.options.map((option) {
                bool isCorrect = option == question.correctOption;
                return ListTile(
                  leading: Icon(
                    isCorrect ? Icons.check_circle : Icons.circle_outlined,
                    color: isCorrect ? Colors.green : Colors.grey,
                  ),
                  title: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
