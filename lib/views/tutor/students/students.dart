// File: lib/screens/analytics_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insync/views/tutor/students/performance_card.dart';

import '../../../models/quiz_model.dart';
import '../../../models/response_model.dart';
import 'average_score_chart.dart';
import 'participant_rate.dart';


class AnalyticScreen extends StatefulWidget {
  @override
  _AnalyticScreenState createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Data holders
  List<Quiz> _quizzes = [];
  List<ResponseModel> _responses = [];
  int _totalStudents = 0;
  double _overallAverageScore = 0.0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  Future<void> _fetchAnalyticsData() async {
    try {
      // Fetch all quizzes
      QuerySnapshot quizSnapshot =
          await _firestore.collection('quizzes').get();
      List<Quiz> quizzes = quizSnapshot.docs
          .map((doc) => Quiz.fromDocument(doc))
          .toList();

      // Fetch all responses
      QuerySnapshot responseSnapshot =
          await _firestore.collection('responses').get();
      List<ResponseModel> responses = responseSnapshot.docs
          .map((doc) => ResponseModel.fromDocument(doc))
          .toList();

      // Fetch total number of students
      QuerySnapshot studentSnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'student')
          .get();
      int totalStudents = studentSnapshot.docs.length;

      // Calculate overall average score
      double totalScore = 0.0;
      responses.forEach((response) {
        totalScore += response.score;
      });
      double overallAverage =
          responses.isNotEmpty ? totalScore / responses.length : 0.0;

      setState(() {
        _quizzes = quizzes;
        _responses = responses;
        _totalStudents = totalStudents;
        _overallAverageScore = overallAverage;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching analytics data: $e");
      setState(() {
        _isLoading = false;
      });
      // Optionally, show a snackbar or dialog
    }
  }

  // Calculate average score per quiz
  Map<String, double> get averageScoresPerQuiz {
    Map<String, double> avgScores = {};
    _quizzes.forEach((quiz) {
      List<ResponseModel> quizResponses =
          _responses.where((resp) => resp.quizId == quiz.id).toList();
      if (quizResponses.isNotEmpty) {
        double total = quizResponses.fold(
            0.0, (sum, response) => sum + response.score.toDouble());
        avgScores[quiz.title] = total / quizResponses.length;
      } else {
        avgScores[quiz.title] = 0.0;
      }
    });
    return avgScores;
  }

  // Calculate participation rate per quiz
  Map<String, double> get participationRatePerQuiz {
    Map<String, double> participation = {};
    _quizzes.forEach((quiz) {
      int responsesCount =
          _responses.where((resp) => resp.quizId == quiz.id).length;
      double rate = _totalStudents > 0 ? (responsesCount / _totalStudents) * 100 : 0.0;
      participation[quiz.title] = rate;
    });
    return participation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _quizzes.isEmpty
              ? Center(child: Text('No quizzes available for analytics.'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overall Performance
                      OverallPerformanceCard(
                        averageScore: _overallAverageScore,
                      ),
                      SizedBox(height: 24),

                      // Average Score per Quiz
                      Text(
                        'Average Score per Quiz',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      AverageScoreChart(
                        dataMap: averageScoresPerQuiz,
                      ),
                      SizedBox(height: 24),

                      // Participation Rate per Quiz
                      Text(
                        'Participation Rate per Quiz (%)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ParticipationRateChart(
                        dataMap: participationRatePerQuiz,
                      ),
                      SizedBox(height: 24),

                      // Additional analytics can be added here
                    ],
                  ),
                ),
    );
  }
}
