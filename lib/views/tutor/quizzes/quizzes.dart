// File: lib/screens/quizzes_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/quiz_model.dart';
import 'quiz_detail.dart';
import 'widgets/quiz_list_item.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch quizzes ordered by deadline descending
    Stream<QuerySnapshot> quizzesStream = FirebaseFirestore.instance
        .collection('quizzes')
        .orderBy('deadline', descending: false)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('All Quizzes'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: quizzesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching quizzes.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Parse quizzes
          List<Quiz> quizzes = snapshot.data!.docs
              .map((doc) => Quiz.fromDocument(doc))
              .toList();

          // Separate into upcoming and past
          DateTime now = DateTime.now();
          List<Quiz> upcomingQuizzes =
              quizzes.where((quiz) => quiz.deadline.isAfter(now)).toList();
          List<Quiz> pastQuizzes =
              quizzes.where((quiz) => quiz.deadline.isBefore(now)).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upcoming Quizzes
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Upcoming Quizzes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                upcomingQuizzes.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('No upcoming quizzes.'),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: upcomingQuizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = upcomingQuizzes[index];
                          return QuizListItem(
                            quiz: quiz,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QuizDetailsScreen(quiz: quiz),
                                ),
                              );
                            },
                          );
                        },
                      ),
                SizedBox(height: 24),
                // Past Quizzes
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Past Quizzes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                pastQuizzes.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('No past quizzes.'),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: pastQuizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = pastQuizzes[index];
                          return QuizListItem(
                            quiz: quiz,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QuizDetailsScreen(quiz: quiz),
                                ),
                              );
                            },
                          );
                        },
                      ),
                SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
