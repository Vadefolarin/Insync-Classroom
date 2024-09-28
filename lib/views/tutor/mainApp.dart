import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insync/utils/colors.dart';
import 'package:insync/views/student/dashboard/home.dart';
import 'package:insync/views/student/quizzes/quizzes.dart';
import 'package:insync/views/student/results/results.dart';
import 'package:insync/views/tutor/dashboard/home.dart';
import 'package:insync/views/tutor/quizzes/quizzes.dart';
import 'package:insync/views/tutor/profile/profileScreen.dart';
import 'package:insync/views/tutor/students/students.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.isTutor});
  final bool isTutor;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late ValueNotifier<int> _currentIndexNotifier;
  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (_, int value, __) {
        return widget.isTutor
            ? Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: value,
                  backgroundColor: Colors.white,
                  onTap: (selectedItem) {
                    _currentIndexNotifier.value = selectedItem;
                  },
                  selectedLabelStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  selectedItemColor: kcolorMainPrimary,
                  unselectedItemColor: Colors.black,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        // color: value == 0 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/quizzes.svg',
                        // color: value == 0 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Quizzes',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/students.svg',
                        // color: value == 1 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Analytics',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/results.svg',
                        // color: value == 2 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
                body: value == 0
                    ?  HomeScreen()
                    : value == 1
                        ?  const QuizScreen()
                        : value == 2
                            ?  const AnalyticScreen()
                            : value == 3
                                ?  const ProfileScreen()
                                : Container(),
              )
            // for students
            : Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: value,
                  backgroundColor: Colors.white,
                  onTap: (selectedItem) {
                    _currentIndexNotifier.value = selectedItem;
                  },
                  selectedLabelStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  selectedItemColor: kcolorMainPrimary,
                  unselectedItemColor: Colors.black,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        // color: value == 0 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/quizzes.svg',
                        // color: value == 0 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Quizzes',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/results.svg',
                        // color: value == 2 ? kColorMainPrimary : kColorMediumGray,
                      ),
                      label: 'Results',
                    ),
                  ],
                ),
                body: value == 0
                    ? const StudentHomeScreen()
                    : value == 1
                        ? const StudentQuizzes()
                        : value == 2
                            ? const StudentResultsScreen()
                            : Container(),
              );
      },
    );
  }
}
