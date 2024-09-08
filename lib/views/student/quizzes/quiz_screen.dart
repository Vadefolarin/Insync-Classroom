import 'package:flutter/material.dart';
import 'package:insync/views/student/quizzes/completed_quiz_screen.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({super.key, required this.question, required this.quizanswers});
  List question;
  List quizanswers;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  ValueNotifier<String> selectedOption = ValueNotifier('');
  int _currentPage = 1;
  int totalPages = 1;

  bool isSelected = false;
  PageController _pageController = PageController(
    initialPage: 1,
  );

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController = PageController();
    super.dispose();
  }

  int testLenght = 1;
  List<Widget> _buildPageIndicator() {
    final List<Widget> list = [];
    for (int i = 0; i < testLenght; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 7.0),
        height: 5.0,
        width: 43.0,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF5C2BA8) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    testLenght = widget.question.length ?? 1;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Quiz 1',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: testLenght,
              itemBuilder: (BuildContext context, int index) {
                return QuestionCard(
                  widget.question[index],
                  totalPages = index.toInt() + 1,
                );
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Center QuestionCard(
    questions,
    int questionNo,
  ) {
    return Center(
      child: Card(
        margin: const EdgeInsets.only(
          left: 21,
          right: 21,
          top: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2.0,
        color: Colors.white,
        child: Container(
          height: 620,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.only(top: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        previousPage();
                      });
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        " Question ${questionNo.toString()}",
                        style: const TextStyle(
                          color: Color(0xFF242424),
                          fontSize: 21,
                          // fontFamily: TRENDA_BOLD,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print(widget.quizanswers.length);
                      nextPage();

                      // if (isSelected || _throwShotAway) {
                      //   nextPage();
                      //   setState(() {
                      //     isSelected = false;
                      //     _throwShotAway = false;
                      //   });
                      // }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.5),
              const Divider(
                color: Color(0xFFE5E5E5),
                thickness: 1,
              ),
              const SizedBox(height: 26.5),
              Text(
                '$questions',
                style: const TextStyle(
                  color: Color(0xFF242424),
                  fontSize: 18,
                  // fontFamily: TRENDA_BOLD,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 26.5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.quizanswers.asMap().entries.map((e) {
                          print('e.key ${e.key}---------------------------');

                          return ValueListenableBuilder(
                            valueListenable: selectedOption,
                            builder: (BuildContext context, String value, _) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: CheckboxListTile(
                                  title: Text(e.value),
                                  value:
                                      selectedOption.value == e.key as String,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedOption.value = e.key as String;
                                      isSelected = true;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        }).toList() ??
                        [],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    nextPage();
                  });
                  isSelected = false;
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF5C2BA8)
                        : const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        // fontFamily: TRENDA_BOLD,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  gotoSelectedPage() {
    if (_currentPage == 0) {
      Future.delayed(
        const Duration(seconds: 1),
      ).then((value) => (value) {
            _currentPage++;
          });
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
    );
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    print(_pageController.page!.toInt());
    print('length ${widget.question.length}');
    if (_pageController.page!.toInt() == widget.question.length - 1) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: CompletedQuizScreen(),
        ),
      );
    }
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

// Map<String, String> answerOptions = {
//   'option1': 'Paris',
//   'option2': 'London',
//   'option3': 'Berlin',
//   'option4': 'Madrid',
// };
