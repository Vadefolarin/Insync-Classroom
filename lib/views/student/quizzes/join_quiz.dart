import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinQuiz extends ConsumerStatefulWidget {
  const JoinQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinQuizState();
}

class _JoinQuizState extends ConsumerState<JoinQuiz> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Join Quiz',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(height: 43),
        const Text(
          'Input the code received for the quiz below to join',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Container(
                width: 100,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 17,
                  left: 24,
                  right: 24,
                ),
                child: const Center(
                  child: Text(
                    'Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                )),
            hintStyle: const TextStyle(
              color: Color(0xFFC5D86D),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 53),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    content: QuizJoined(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFC5D86D),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 17,
                  left: 24,
                  right: 24,
                ),
                child: const Center(
                  child: Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFC5D86D),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.only(
                  top: 17,
                  bottom: 17,
                  left: 24,
                  right: 24,
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QuizJoined extends ConsumerStatefulWidget {
  const QuizJoined({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizJoinedState();
}

class _QuizJoinedState extends ConsumerState<QuizJoined> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 46),
        const Icon(Icons.check_circle_outline_rounded,
            color: Color.fromARGB(255, 7, 7, 6), size: 100),
        const SizedBox(height: 23),
        const Text(
          'Quiz joined successfully',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(height: 23),
        const Text(
          'Python for noobs Quiz one',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(height: 48),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFC5D86D),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 54,
              right: 54,
            ),
            child: const Center(
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
