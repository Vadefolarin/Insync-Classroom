import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'take_quiz_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Student Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              _buildWelcomeBanner(),
              const SizedBox(height: 20),
              _buildSectionTitle('Active Quizzes'),
              _buildQuizList(
                  fetchActiveQuizzes(), false), // Fetch active quizzes
              const SizedBox(height: 20),
              _buildSectionTitle('Completed Quizzes'),
              _buildQuizList(
                  fetchCompletedQuizzes(), true), // Fetch completed quizzes
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"Stay focused and ace your quizzes!"',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuizList(
      Future<List<Map<String, dynamic>>> quizzesFuture, bool isCompleted) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: quizzesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No quizzes available.');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final quiz = snapshot.data![index];
            final Timestamp deadlineTimestamp = quiz['deadline'];
            final DateTime deadlineDate = deadlineTimestamp.toDate();
            final formattedDate =
                DateFormat('MMM dd, yyyy – hh:mm a').format(deadlineDate);

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  quiz['title'] ?? 'Quiz Title',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      quiz['description'] ?? 'Quiz Description',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.redAccent, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Deadline: $formattedDate',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: isCompleted
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.arrow_forward_ios,
                        color: Colors.blueAccent),
                onTap: isCompleted
                    ? () {
                        // Navigate to result page (for completed quizzes)
                        _showQuizResult(quiz);
                      }
                    : () {
                        // Navigate to take quiz page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TakeQuizScreen(quizId: quiz['id']),
                          ),
                        );
                      },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchActiveQuizzes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('deadline', isGreaterThan: Timestamp.now())
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchCompletedQuizzes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('completedBy',
            arrayContains: 'studentId') // Assume studentId is used
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void _showQuizResult(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Result'),
          content: Text('You scored: ${quiz['score']}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
