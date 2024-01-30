import 'package:flutter/material.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  List<String> questions = [];

  @override
  Widget build(BuildContext context) {
    print('................... $questions----------------');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return questions.isEmpty
                      ? const Text(
                          'Click on Add Question to add questions',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Enter question ${index + 1}',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  deleteQuestion(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                questions[index] = value;
                              });
                            },
                          ),
                        );

                  // ListTile(
                  //   title: Text(questions[index]),
                  // );

                  return null;
                },
              ),
            ),
            InkWell(
              onTap: () {
                _sendQuestions();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                child: const Text(
                  'Send Question',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      questions.add('');
    });
  }

  void deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  void _sendQuestions() {
    // Implement logic to send questions
    // e.g. send API request, save to database, etc.
  }
}
