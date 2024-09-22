import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insync/views/student/quizzes/join_quiz.dart';
import 'package:insync/views/student/quizzes/quiz_screen.dart';
import 'package:insync/views/tutor/dashboard/home.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  List upComingQuizdata = [];

  @override
  Widget build(BuildContext context) {
    getQuestions();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFEDDF),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              content: JoinQuiz(),
            ),
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add_alarm,
              color: Color(0xFF0D1321),
            ),
            SizedBox(width: 5),
            Text(
              'Join Quiz',
              style: TextStyle(
                color: Color(0xFF0D1321),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adedayo Victor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text('IFT/17/2390',
                              style: TextStyle(
                                color: Color(0xFFC5D86D),
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                              ))
                        ]),
                    const Spacer(),
                    SvgPicture.asset('assets/icons/message.svg'),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        const Icon(Icons.notifications),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC5D86D),
                                  borderRadius: BorderRadius.circular(10),
                                )))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                StudentUpcomingQuizSlide(
                  isfullScreen: false,
                  upcomingQuizData: upComingQuizdata,
                ),
                const SizedBox(height: 20),
                // const CompletedtQuiz(
                //   isfullScreen: false,
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getQuestions() async {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('teachers');

    QuerySnapshot querySnapshot = await questions.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Future.delayed(const Duration(seconds: 5), () {
      print('++++ $allData++++');
      setState(() {
        upComingQuizdata = allData;
      });
      print('________________________ ');

      print('${upComingQuizdata.map((e) => e['title'])}');
    });
  }
}

class StudentUpcomingQuizSlide extends StatelessWidget {
  StudentUpcomingQuizSlide({
    super.key,
    required this.isfullScreen,
    required this.upcomingQuizData,
  });
  final bool isfullScreen;
  List upcomingQuizData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xff00000033).withOpacity(0.20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff00000033).withOpacity(0.20),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 25,
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Upcoming quizzes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const Spacer(),
              isfullScreen
                  ? const SizedBox()
                  : const Text(
                      'Quiz directory',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
              const SizedBox(width: 5),
              isfullScreen
                  ? const SizedBox()
                  : const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFC5D86D),
                    )
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: upcomingQuizData
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        List newQuestion = e['questions'];
                        List newAnswer = e['answers'];
                        // newQuestion.add(e['questions'].toString());
                        // newQuestion.expand((element) );

                        print(newQuestion);

                        print(newAnswer);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              // question: e['questions'],
                              question: newQuestion,
                              quizanswers: newAnswer,
                            ),
                          ),
                        );
                      },
                      child: e['title'] == ''
                          ? const Text(
                              'No Upcoming Quiz at the monet',
                              style: TextStyle(color: Colors.black),
                            ) :
                               Center(child: Text('Removed'),),
                          // : UpcomingQuizCard(
                          //     title: e['title'],
                          //     date: e['description'],
                          //   ),
                    ),
                  )
                  .toList(),

              // UpcomingQuizCard(
              //   title: 'Introduction to computer\nprogramming',
              //   date: '12 / 03 / 2023 | 09:00 AM',
              // ),
              // SizedBox(height: 20),
              // UpcomingQuizCard(
              //   title: 'Theory of computation',
              //   date: '27 / 05 / 2023 | 12:30 PM',
              // ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
