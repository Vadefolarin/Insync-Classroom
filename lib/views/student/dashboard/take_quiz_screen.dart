import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class TakeQuizScreen extends StatefulWidget {
  final String quizId;

  const TakeQuizScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  _TakeQuizScreenState createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  final PageController _pageController = PageController();
  List<dynamic> _questions = [];
  List<String> _studentAnswers = [];
  bool _isLoading = true;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
  }

  Future<void> _fetchQuizData() async {
    try {
      DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc('JHNcQjRV074QZjElyCSW')
          .get();

      if (quizSnapshot.exists && quizSnapshot.data() != null) {
        final quizData = quizSnapshot.data() as Map<String, dynamic>;
        if (quizData['questions'] != null && quizData['questions'] is List) {
          setState(() {
            _questions = quizData['questions'];
            _studentAnswers = List<String>.filled(
                _questions.length, ''); // Initialize empty answers
            _isLoading = false; // Stop loading
          });
        } else {
          throw Exception('No questions found in this quiz.');
        }
      } else {
        throw Exception('Quiz not found.');
      }
    } catch (e) {
      print('Error fetching quiz data: $e');
      setState(() {
        _isLoading = false; // Stop loading, even if there's an error
      });
    }
  }

  void _submitQuiz() {
    int score = 0;
    for (int i = 0; i < _studentAnswers.length; i++) {
      // Assuming you need to compare with correct answers, adjust the logic if needed
      if (_studentAnswers[i] == _questions[i]['correctOption']) {
        score++;
      }
    }

    // Save the result to Firestore
    FirebaseFirestore.instance.collection('quizzes').doc(widget.quizId).update({
      'completedBy': FieldValue.arrayUnion(['studentId']),
      'scores': FieldValue.arrayUnion([
        {
          'studentId': 'studentId', // Replace with actual student ID
          'score': score,
        }
      ])
    });

    _showResult(score);
  }

  void _showResult(int score) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Submitted'),
          content: Text('You scored: $score out of ${_studentAnswers.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to home screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onAnswerSelected(String selectedAnswer, int questionIndex) {
    setState(() {
      _studentAnswers[questionIndex] = selectedAnswer;
    });

    // Automatically move to the next question
    if (questionIndex < _questions.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // If it's the last question, submit the quiz
      // _submitQuiz();
      toast('End of question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Quiz'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              itemCount: _questions.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final question =
                    _questions[index]['questionText'] ?? 'No question';
                final options =
                    List<String>.from(_questions[index]['options'] ?? []);

                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.primaries[index % Colors.primaries.length]
                            .withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question ${index + 1}/${_questions.length}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                question,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 20),
                              ...options.map((option) {
                                return RadioListTile<String>(
                                  title: Text(option),
                                  value: option,
                                  groupValue: _studentAnswers[index],
                                  onChanged: (value) {
                                    _onAnswerSelected(value!, index);
                                  },
                                );
                              }).toList(),
                              const SizedBox(height: 20),
                              // if (index == _questions.length - 1)
                              //   Center(
                              //     child: ElevatedButton(
                              //       onPressed: _submitQuiz,
                              //       style: ElevatedButton.styleFrom(
                              //         backgroundColor: Colors.teal, // Button color
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 12, horizontal: 24),
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(30),
                              //         ),
                              //         elevation: 5,
                              //       ),
                              //       child: const Text(
                              //         'Submit Quiz',
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //   )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (index == _questions.length - 1)
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal, // Button color
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Submit Quiz',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
    );
  }
}
