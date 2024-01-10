import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insync/utils/colors.dart';
import 'package:insync/views/tutor/quizzes/newQuiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFEDDF),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog.adaptive(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(0),
              content: NewQuiz(),
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
              'New Quiz',
              style: TextStyle(
                color: Color(0xFF0D1321),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                          Text(
                            'vadedayo@futa.edu.ng',
                            style: TextStyle(
                              color: Color(0xFFC5D86D),
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const UpcomingQuizSlide(),
                  const SizedBox(height: 20),
                  const CompletedtQuiz(
                    isfullScreen: false,
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                        const Row(
                          children: [
                            Text(
                              'Student List',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Student directory',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFC5D86D),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        TabBar(
                          controller: _tabController,
                          isScrollable: false,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins',
                          ),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.all(10),
                              text: 'Group 1',
                            ),
                            Tab(
                              text: 'Group 2',
                            ),
                            Tab(
                              text: 'Group 3',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: TabBarView(
                            controller: _tabController,
                            children: const [
                              Group1(),
                              Group1(),
                              Group1(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

List<String> names = [
  'Adedayo Victor',
  'Adebayo Rasheed',
  'Adeyemi Oluwaseun',
  'Ibukun Olofin',
  'Wasilatu Shadia'
];
List<String> classRank = [
  '2nd | Average score: 87%',
  '12th | Average score: 69%',
  '17th | Average score: 60%',
  '5th | Average score: 80%',
  '2nd | Average score: 87%',
];

class Group1 extends StatelessWidget {
  const Group1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/quiz1.png'),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          title: Text(
            names[index],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            classRank[index],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward),
        );
      },
    );
  }
}

class CompletedtQuiz extends StatelessWidget {
  const CompletedtQuiz({
    super.key,
    required this.isfullScreen,
  });
  final bool isfullScreen;

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
                'Completed Quizzes',
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
                      'Results',
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
          const MyTable(),
        ],
      ),
    );
  }
}

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: const Color(0xff00000033).withOpacity(0.20),
        borderRadius: BorderRadius.circular(10),
        style: BorderStyle.solid,
        width: 1,
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      textBaseline: TextBaseline.alphabetic,

      defaultColumnWidth: const FlexColumnWidth(2),
      // columnWidths: const {
      //   0: FlexColumnWidth(2),
      //   1: FlexColumnWidth(2),
      //   2: FlexColumnWidth(2),
      //   3: FlexColumnWidth(2),
      // },
      children: [
        const TableRow(
          decoration: BoxDecoration(
            color: Color(0xFF0D1321),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('Title', style: TextStyle(color: Colors.white)),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('Group name', style: TextStyle(color: Colors.white)),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('No. of persons in group',
                  style: TextStyle(color: Colors.white)),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('Date', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
          children: const [
            TableCell(
              child: Text(
                'Assembly language',
              ),
            ),
            TableCell(
              child: Text('Group 1'),
            ),
            TableCell(
              child: Text('23 Persons'),
            ),
            TableCell(
              child: Text('12 / 02 / 2023'),
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
          children: const [
            TableCell(
              child: Text('Python'),
            ),
            TableCell(
              child: Text('Group 2'),
            ),
            TableCell(
              child: Text('17 Persons'),
            ),
            TableCell(
              child: Text('12 / 02 / 2023'),
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
          children: const [
            TableCell(
              child: Text('C programming'),
            ),
            TableCell(
              child: Text('Group 3'),
            ),
            TableCell(
              child: Text('30 Persons'),
            ),
            TableCell(
              child: Text('12 / 02 / 2023'),
            ),
          ],
        ),
      ],
    );
  }
}

class UpcomingQuizSlide extends StatelessWidget {
  const UpcomingQuizSlide({
    super.key,
  });

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
      child: const Column(
        children: [
          Row(
            children: [
              Text(
                'Upcoming quizzes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Spacer(),
              Text(
                'Quiz directory',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.arrow_forward,
                color: Color(0xFFC5D86D),
              )
            ],
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                UpcomingQuizCard(
                  title: 'Introduction to computer\nprogramming',
                  date: '12 / 03 / 2023 | 09:00 AM',
                ),
                UpcomingQuizCard(
                  title: 'Theory of computation',
                  date: '27 / 05 / 2023 | 12:30 PM',
                ),
                UpcomingQuizCard(
                  title: 'Introduction to computer programming',
                  date: '12 / 03 / 2023 | 09:00 AM',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingQuizCard extends StatelessWidget {
  const UpcomingQuizCard({
    super.key,
    required this.title,
    required this.date,
  });
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xff00000033).withOpacity(0.2),
        ),
      ),
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/images/quiz1.png'),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
