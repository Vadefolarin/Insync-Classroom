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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    StudentUpcomingQuizSlide(
                        isfullScreen: true, upcomingQuizData: const []),
                           const Center(child: Text('Removed'),),
                    // const CompletedtQuiz(isfullScreen: true),
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
