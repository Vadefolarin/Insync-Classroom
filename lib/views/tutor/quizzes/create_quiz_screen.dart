import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/utils/loader.dart';

List<String> answer = <String>['true', 'false'];

class CreateQuizScreen extends StatefulWidget {
  final String title;
  const CreateQuizScreen({super.key, required this.title});

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  List<String> questions = [];
  List<String> answers = [];

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
                              prefixIcon: const DropDownMenuBody(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  deleteQuestion(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter question';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                questions[index] = value;
                                postQuestions[value] = answer[index];

                                // postQuestions.entries
                                //     .map((e) => e.key == value
                                //         ? e.value = answer[index]
                                //         : null)
                                //     .toList();
                              });
                            },
                          ),
                        );
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

  void _sendQuestions() async {
    const Loader();

    CollectionReference question =
        FirebaseFirestore.instance.collection('teachers');

    question.doc('questions').set(widget.title).then(
      (value) {
        print("Quiz Added");
        Navigator.pop(context);
      },
    ).catchError(
      (error) {
        print("Failed to add quiz: $error");
        Navigator.pop(context);
      },
    );

    // DocumentSnapshot? documentSnapshot = await question.doc('uniqueId').get();
  }
}

Map<String, String> postQuestions = {
  // 'question': 'true',
  // 'answer': 'false',
};

class DropDownMenuBody extends ConsumerStatefulWidget {
  const DropDownMenuBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DropDownMenuBodyState();
}

class _DropDownMenuBodyState extends ConsumerState<DropDownMenuBody> {
  String dropdownValue = answer.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      expandedInsets: const EdgeInsets.all(16.0),
      width: 30,
      initialSelection: answer.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          answer.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
