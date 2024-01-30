import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/views/tutor/quizzes/create_quiz_screen.dart';

class NewQuiz extends ConsumerStatefulWidget {
  const NewQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewQuizState();
}

class _NewQuizState extends ConsumerState<NewQuiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Text(
                    'Set up a new quiz',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateQuizScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const Icon(Icons.done),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: const Icon(Icons.close, weight: 20),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 11),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          width: 70,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                            top: 9,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: const Center(
                              child: Text(
                            'Title:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ))),
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5D86D),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: '10',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            prefixIcon: Container(
                              width: 70,
                              height: 55,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDDF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                top: 9,
                                bottom: 10,
                                left: 14,
                                right: 15,
                              ),
                              child: const Center(
                                  child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Duration',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    // TextSpan(
                                    //   text: '(in minutes)',
                                    //   style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 16,
                                    //     fontFamily: 'Inter',
                                    //     fontWeight: FontWeight.w400,
                                    //     height: 0,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )),
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFFC5D86D),
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: '15',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            prefixIcon: Container(
                              width: 100,
                              height: 58,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDDF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                // top: 9,
                                // bottom: 10,
                                left: 14,
                                right: 15,
                              ),
                              child: const Center(
                                child: Text(
                                  'No. of questions',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFFC5D86D),
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '10',
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      prefixIcon: Container(
                          width: 100,
                          height: 58,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                            top: 9,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: const Center(
                              child: Text(
                            'Score per question:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ))),
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5D86D),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                            top: 9,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: const Center(
                              child: Text(
                            'Description:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ))),
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5D86D),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.calendar_month, size: 20),
                          SizedBox(width: 10),
                          Text(
                            '11  /  05  /  2023',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.access_time_outlined, size: 20),
                          Text(
                            '13 : 00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      prefixIcon: Container(
                          width: 83,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                            top: 9,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: const Center(
                              child: Text(
                            'Schedule:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ))),
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5D86D),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Divider(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Use question bank:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 9,
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bank one',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                        SizedBox(width: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Reveal answers after quiz',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 9,
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'yes',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                        SizedBox(width: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
