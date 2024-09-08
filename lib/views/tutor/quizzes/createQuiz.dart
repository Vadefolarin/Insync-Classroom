import 'package:flutter/material.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({super.key});

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _formKey = GlobalKey<FormState>();
  final List<Quiz> _quizzes = [];

  @override
  void initState() {
    super.initState();
    // Initialize with 10 quizzes
    for (int i = 0; i < 10; i++) {
      _quizzes.add(Quiz());
    }
  }

  void _addQuiz() {
    setState(() {
      _quizzes.add(Quiz());
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the quiz data as needed
      for (int i = 0; i < _quizzes.length; i++) {
        print('Quiz ${i + 1}: ${_quizzes[i].question}');
        print('Answers: ${_quizzes[i].answers}');
        print('Correct Answer: ${_quizzes[i].correctAnswer}');
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
              return QuizInput(
                quiz: _quizzes[index],
                key: UniqueKey(),
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
