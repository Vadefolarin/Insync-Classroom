import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insync/views/student/dashboard/home.dart';
import 'package:insync/views/tutor/dashboard/home.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFEDDF),
          title: const Text('Quizzes',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xff00000033).withOpacity(0.20),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/alarm.svg',
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Set up a new quiz',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff00000033).withOpacity(0.20),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/vault.svg',
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Question Bank',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                    const CompletedtQuiz(isfullScreen: true),
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
