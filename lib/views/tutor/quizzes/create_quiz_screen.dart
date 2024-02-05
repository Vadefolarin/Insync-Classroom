import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/utils/loader.dart';

List<String> booleananswer = <String>['true', 'false'];
List<String> answers = [];

class CreateQuizScreen extends StatefulWidget {
  final String title;
  final String description;
  const CreateQuizScreen({
    super.key,
    required this.title,
    required this.description,
  });

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
        title: Text('${widget.title} Quiz'),
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
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Text(widget.description,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
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
                              hintText:
                                  '             Enter question ${index + 1}',
                              errorMaxLines: 2,
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
                                postQuestions['questions'] = questions;
                                // List.from(questions);
                                // postQuestions['answers'] =
                                //     List.from(answers).toString();
                                // postQuestions.update(key, (value) => null)

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
                // _sendQuestions();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text(
                        'Are you sure you want to send question?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                    actions: [
                      InkWell(
                        onTap: () {
                          _sendQuestions();
                        },
                        child: const Text('Yes'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
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
    postQuestions['title'] = widget.title;
    postQuestions['description'] = widget.description;
    print(postQuestions.toString());
    const Loader();

    CollectionReference question =
        FirebaseFirestore.instance.collection('teachers');

    if (postQuestions.isNotEmpty) {
      question.doc(widget.title).set(postQuestions).then(
        (value) {
          // postQuestions;

          print("Quiz Added");
          Navigator.pop(context);
        },
      ).catchError(
        (error) {
          print("Failed to add quiz: $error");
          Navigator.pop(context);
        },
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text('You have not set any question yet'),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          });
    }
  }
}

Map<String, dynamic> postQuestions = {
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
  String dropdownValue = booleananswer.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 120,
      // initialSelection: booleananswer.first,
      hintText: 'Answer',
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
          answers.add(dropdownValue);
          postQuestions['answers'] = answers;

          // List.from(answers).toString();
        });
      },
      dropdownMenuEntries:
          booleananswer.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
