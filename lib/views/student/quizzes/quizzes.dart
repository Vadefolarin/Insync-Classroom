import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/views/student/dashboard/home.dart';
import 'package:insync/views/tutor/dashboard/home.dart';

class StudentQuizzes extends ConsumerWidget {
  const StudentQuizzes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFEDDF),
          title: const Text('Quizzes',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    StudentUpcomingQuizSlide(isfullScreen: true),
                    CompletedtQuiz(isfullScreen: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
