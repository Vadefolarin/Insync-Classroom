import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/loader.dart';

class QuizForm extends StatefulWidget {
  final String title;
  final String description;

  const QuizForm({super.key, required this.title, required this.description});

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _formKey = GlobalKey<FormState>();
  final List<Quiz> _quizzes = [];

  String? userId;

  @override
  void initState() {
    super.initState();
    // Initialize with 3 quizzes
    for (int i = 0; i < 3; i++) {
      _quizzes.add(Quiz());
    }
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
  }

  void _addQuiz() {
    setState(() {
      _quizzes.add(Quiz());
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: Loader(),
          );
        },
      );
      // Prepare quiz data for Firestore
      List<Map<String, dynamic>> quizData = [];
      for (var quiz in _quizzes) {
        quizData.add({
          'questionText': quiz.question,
          'options': quiz.answers,
          'correctOption': quiz.correctAnswer,
        });
      }

      // Firestore reference
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Prepare final quiz structure
      final newQuiz = {
        'title': widget.title,
        'description': widget.description,
        'questions': quizData,
        'createdBy': userId, // Replace with actual teacherId
        'createdAt': FieldValue.serverTimestamp(),
        'deadline': FieldValue.serverTimestamp(), // Customize as needed
      };

      try {
        // Save quiz to Firestore
        await firestore.collection('quizzes').add(newQuiz);

        // Notify success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz submitted successfully!')),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit quiz: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Input Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: _quizzes.length + 1,
            itemBuilder: (context, index) {
              if (index == _quizzes.length) {
                return ElevatedButton(
                  onPressed: _addQuiz,
                  child: const Text('Add Another Quiz'),
                );
              }
              return Dismissible(
                key: ValueKey(_quizzes[index]),
                onDismissed: (direction) {
                  setState(() {
                    _quizzes.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: QuizInput(
                  quiz: _quizzes[index],
                  key: UniqueKey(),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Submit Quizzes',
        child: const Icon(Icons.save),
      ),
    );
  }
}

class Quiz {
  String? question;
  List<String> answers = [''];
  String? correctAnswer;

  Quiz();
}

class QuizInput extends StatefulWidget {
  final Quiz quiz;

  const QuizInput({required this.quiz, Key? key}) : super(key: key);

  @override
  _QuizInputState createState() => _QuizInputState();
}

class _QuizInputState extends State<QuizInput> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers = [];

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.quiz.question ?? '';
    for (var answer in widget.quiz.answers) {
      _answerControllers.add(TextEditingController(text: answer));
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAnswer() {
    setState(() {
      _answerControllers.add(TextEditingController());
      widget.quiz.answers.add('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quiz',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              labelText: 'Enter quiz question',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the quiz question';
              }
              return null;
            },
            onSaved: (value) {
              widget.quiz.question = value;
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Answers',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ..._buildAnswerFields(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addAnswer,
            child: const Text('Add Another Answer'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnswerFields() {
    List<Widget> fields = [];
    for (int i = 0; i < _answerControllers.length; i++) {
      fields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _answerControllers[i],
                decoration: InputDecoration(
                  labelText: 'Answer ${i + 1}',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.quiz.answers[i] = value!;
                },
              ),
            ),
            Radio<String>(
              value: _answerControllers[i].text,
              groupValue: widget.quiz.correctAnswer,
              onChanged: (value) {
                setState(() {
                  widget.quiz.correctAnswer = value!;
                });
              },
            ),
            const Text('Correct'),
          ],
        ),
      ));
    }
    return fields;
  }
}
