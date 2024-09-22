// File: lib/models/response.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseModel {
  final String id;
  final String quizId;
  final String studentId;
  final List<Answer> answers;
  final int score;
  final DateTime submittedAt;

  ResponseModel({
    required this.id,
    required this.quizId,
    required this.studentId,
    required this.answers,
    required this.score,
    required this.submittedAt,
  });

  factory ResponseModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ResponseModel(
      id: doc.id,
      quizId: data['quizId'] ?? '',
      studentId: data['studentId'] ?? '',
      answers: List<Answer>.from(
        data['answers']?.map((a) => Answer.fromMap(a)) ?? [],
      ),
      score: data['score'] ?? 0,
      submittedAt: (data['submittedAt'] as Timestamp).toDate(),
    );
  }
}

class Answer {
  final String questionId;
  final String selectedOption;

  Answer({
    required this.questionId,
    required this.selectedOption,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      questionId: map['questionId'] ?? '',
      selectedOption: map['selectedOption'] ?? '',
    );
  }
}
