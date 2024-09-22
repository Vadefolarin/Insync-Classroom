// File: lib/models/quiz.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final String createdBy;
  final DateTime createdAt;
  final DateTime deadline;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.createdBy,
    required this.createdAt,
    required this.deadline,
  });

  factory Quiz.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Quiz(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      questions: List<Question>.from(
        data['questions']?.map((q) => Question.fromMap(q)) ?? [],
      ),
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      deadline: (data['deadline'] as Timestamp).toDate(),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctOption;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['questionText'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctOption: map['correctOption'] ?? '',
    );
  }
}
