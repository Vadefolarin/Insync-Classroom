// // ignore_for_file: non_constant_identifier_names, must_be_immutable

// import 'dart:developer';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:how_bodi_mobile/helpers/margin.dart';
// import 'package:how_bodi_mobile/helpers/extensions.dart';

// import 'package:how_bodi_mobile/service/test/test_answer.dart';
// import 'package:stacked/stacked.dart';
// import '../../helpers/strings.dart';
// import '../../model/tests/answer_model.dart';
// import '../../model/tests/test_data_model.dart';
// import '../../service/test/takeSingleTests.dart';
// import '../../src/colors.dart';
// import 'hurray.dart';
// import 'widget/child_symptoms_forParent.dart';

// var testId;
// var testResponse;

// class QuestionScreen extends StatefulWidget {
//   String? sId;
//   QuestionScreen(this.sId, {Key? key}) : super(key: key);

//   @override
//   State<QuestionScreen> createState() => _QuestionScreenState();
// }

// var testName;
// var sendAnswer = '';
// List<String> StoreAnswer = [sendAnswer];
// // List<bool> listBool = StoreAnswer.map((e) => e == "true").toList();
// // List StoreAnswer = [];

// class _QuestionScreenState extends State<QuestionScreen> {
//   late Future<TestDataModel> testDataModel;
//   bool _throwShotAway = false;
//   ValueNotifier<String> selectedOption = ValueNotifier('');
//   int totalPages = 1;
//   var resp = {};
//   List fetchAnswers = [];

//   bool isSelected = false;

//   int _currentPage = 1;
//   PageController _pageController = PageController(
//     initialPage: 1,
//   );

//   @override
//   void initState() {
//     StoreAnswer.clear();
//     _pageController = PageController();
//     testDataModel = SingleTestData.testData!.testsLists(
//       widget.sId.toString(),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController = PageController();
//     StoreAnswer.clear();
//     super.dispose();
//   }

//   int testLenght = 1;

//   // final int _numPages = 14;

//   List<Widget> _buildPageIndicator() {
//     final List<Widget> list = [];
//     for (int i = 0; i < testLenght; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return Expanded(
//       child: AnimatedContainer(
//         duration: const Duration(
//           milliseconds: 500,
//         ),
//         // margin: const EdgeInsets.symmetric(horizontal: 7.0),
//         height: 5.0,
//         width: 43.0,
//         decoration: BoxDecoration(
//           color: isActive ? const Color(0xFF5C2BA8) : const Color(0xFFEEEFF3),
//           borderRadius: const BorderRadius.all(Radius.circular(12)),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F3F3),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF3F3F3),
//         elevation: 0.0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: kColorMainPrimary,
//         ),
//         title: const Text(
//           'Test',
//           style: TextStyle(
//             color: kColorMainPrimary,
//             fontSize: 18,
//             fontFamily: TRENDA_BOLD,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const YMargin(27.36),
//           Padding(
//             padding: context.insetsSymetric(horizontal: 21),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: _buildPageIndicator(),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<TestDataModel>(
//               future: testDataModel,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   testLenght = snapshot
//                       .data!.test!.data!.tests![0].questionTypes!.length;
//                   testName =
//                       snapshot.data!.test!.data!.tests![0].testName.toString();
//                   //   snapshot.data?.test.data.tests[0].testName.toString();
//                   return PageView.builder(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: snapshot
//                         .data!
//                         .test!
//                         .data!
//                         .tests?[_pageController.initialPage.toInt()]
//                         .questionTypes!
//                         .length
//                         .toInt(),
//                     itemBuilder: (context, index) {
//                       return QuestionCard(
//                         context,
//                         totalPages = index.toInt() + 1,

//                         // snapshot
//                         //         .data!
//                         //         .test!
//                         //         .data!
//                         //         .tests![_pageController.initialPage.toInt()]
//                         //         .questionTypes!
//                         //         .length
//                         //         .toInt() +
//                         //     1,
//                         snapshot
//                             .data!
//                             .test!
//                             .data!
//                             .tests![_pageController.initialPage.toInt()]
//                             .questionTypes![index]
//                             .questions
//                             .toString(),
//                       );
//                     },
//                     onPageChanged: (value) {
//                       setState(() {
//                         // log(" this is it ${totalPages.toString()}");
//                         //log('------------');
//                         // log(snapshot
//                         //     .data!.test.data.tests[0].questionTypes.length
//                         //     .toString());
//                         _currentPage = value;
//                         log(StoreAnswer.toString());
//                       });
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//           const YMargin(59),
//         ],
//       ),
//     );
//   }

//   ViewModelBuilder<SendAnswerViewModel> QuestionCard(
//     BuildContext context,
//     int QuestionNo,
//     String Question,
//   ) {
//     final theme = Theme.of(context);
//     final oldCheckboxTheme = theme.checkboxTheme;
//     final newCheckBoxTheme = oldCheckboxTheme.copyWith(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//     );

//     return ViewModelBuilder<SendAnswerViewModel>.reactive(
//       viewModelBuilder: () => SendAnswerViewModel(),
//       builder: (_, model, __) {
//         return Center(
//           child: Card(
//             margin: context.insetsOnly(
//               left: 21,
//               right: 21,
//               top: 50,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             elevation: 2.0,
//             color: kColorWhite,
//             child: Container(
//               height: 620,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: kColorWhite,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               padding: context.insetsOnly(top: 26),
//               child: FutureBuilder<TestDataModel>(
//                 future: testDataModel,
//                 builder: (context, snapshot) {
//                   //AnseerOptions fetched from backend
//                   List<String>? answerOption = snapshot
//                       .data?.test?.data?.tests?[0].answerOptions!
//                       .toList();

//                   //   snapshot.data?.test.data.tests[0].answerOptions.toList();
//                   // log(answerOption.toString());

//                   // Map mapAnswer = answerOption!.asMap();
//                   Map<String, dynamic> growableMap = {};
//                   //List fetchAnswers = listBool;
//                   fetchAnswers = StoreAnswer; //List of answers

//                   List mapCounter = List.generate(
//                     fetchAnswers.length,
//                     (index) =>
//                         // Increasing  the list of int, from the lenght of the questions
//                         //and increasing the results by 1, to remove 0 index and start from 1
//                         index + 1,
//                     growable: false,
//                   );

//                   // I am using the mapCounter, using the Integer as key and answer value as value
//                   for (int index in mapCounter) {
//                     growableMap[

//                         // this gro through the list of answers in answer options  and add the value to the map
//                         // Answers are stored in the map as key and value as value
//                         // Answers gotten from Answer Options are only in form of string, but we cant all send them to the backend as string so we have to confirm the type of the answer
//                         //If the string is false send boolean false
//                         //If the string is true send boolean true
//                         //If the string is Disagree Strongly send 1
//                         //If string is Agree Strongly send 2
//                         //ETC
//                         //Check the test documentation for more info
//                         index.toString()] = "${fetchAnswers[index - 1].toString().toLowerCase().trim()}" ==
//                             "true".toLowerCase()
//                         ? true
//                         : "${fetchAnswers[index - 1].toString().toLowerCase().trim()}" ==
//                                 "false".toLowerCase()
//                             ? false
//                             : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                     "Disagree strongly".toLowerCase()
//                                 ? 1
//                                 : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                         "Disagree a little".toLowerCase()
//                                     ? 2
//                                     : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                             "Neither agree nor disagree"
//                                                 .toLowerCase()
//                                         ? 3
//                                         : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                 "Agree a little".toLowerCase()
//                                             ? 4
//                                             : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                     "Agree strongly"
//                                                         .toLowerCase()
//                                                 ? 5
//                                                 : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                         "Not at all"
//                                                             .toLowerCase()
//                                                     ? 0
//                                                     : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                             "A little bit"
//                                                                 .toLowerCase()
//                                                         ? 1
//                                                         : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                                 "Moderately"
//                                                                     .toLowerCase()
//                                                             ? 2
//                                                             : "${fetchAnswers[index - 1].toString().toLowerCase().trim()}" ==
//                                                                     "Quite a bit"
//                                                                         .toLowerCase()
//                                                                 ? 3
//                                                                 : "${fetchAnswers[index - 1].toString().toLowerCase().trim()}" ==
//                                                                         "Extremely"
//                                                                             .toLowerCase()
//                                                                     ? 4
//                                                                     : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                                             "Never"
//                                                                                 .toLowerCase()
//                                                                         ? 0
//                                                                         : "${fetchAnswers[index - 1].toString().toLowerCase()}" ==
//                                                                                 "Sometimes".toLowerCase()
//                                                                             ? 1
//                                                                             : "${fetchAnswers[index - 1].toString().toLowerCase()}" == "Often".toLowerCase()
//                                                                                 ? 2
//                                                                                 : "${fetchAnswers[index - 1].toString().toLowerCase()}" == "Did not apply to me at all".toLowerCase()
//                                                                                     ? 0
//                                                                                     : "${fetchAnswers[index - 1].toString().toLowerCase()}" == "Applied to me to some degree, or some of the time".toLowerCase()
//                                                                                         ? 1
//                                                                                         : "${fetchAnswers[index - 1].toString().toLowerCase()}" == "Applied to me to a considerable degree or a good part of time".toLowerCase()
//                                                                                             ? 2
//                                                                                             : "${fetchAnswers[index - 1].toString().toLowerCase()}" == "Applied to me very much or most of the time".toLowerCase()
//                                                                                                 ? 3
//                                                                                                 : "${fetchAnswers[index - 1].toString().toLowerCase()}";

//                     //    "${'"' + fetchAnswers[index - 1] + '"'}";
//                   }
//                   // after the above function runs, the map will be filled with the new value
//                   // which we would send as response
//                   //for now we print

//                   // print({growableMap});
//                   // log(growableMap.toString());

//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 previousPage();
//                               });
//                             },
//                             child: const Icon(
//                               Icons.arrow_back_ios_new,
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 " Question ${QuestionNo.toString()}",
//                                 style: const TextStyle(
//                                   color: Color(0xFF242424),
//                                   fontSize: 21,
//                                   fontFamily: TRENDA_BOLD,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const YMargin(7),
//                             ],
//                           ),
//                           InkWell(
//                             onTap: () {
//                               if (isSelected || _throwShotAway) {
//                                 nextPage();
//                                 setState(() {
//                                   isSelected = false;
//                                   _throwShotAway = false;
//                                 });
//                               }
//                             },
//                             child: const Icon(
//                               Icons.arrow_forward_ios_sharp,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const YMargin(12.5),
//                       const Divider(),
//                       const YMargin(26.5),
//                       AutoSizeText(
//                         Question,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontFamily: TRENDA_SEMI_BOLD,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       // const YMargin(75),
//                       const YMargin(35),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: snapshot
//                                     .data?.test?.data?.tests?[0].answerOptions
//                                     ?.map(
//                                       (option) => ValueListenableBuilder(
//                                         valueListenable: selectedOption,
//                                         builder: (_, value, __) {
//                                           return Padding(
//                                             padding: context.insetsSymetric(
//                                                 horizontal: 50),
//                                             child: Theme(
//                                               data: theme.copyWith(
//                                                   checkboxTheme:
//                                                       newCheckBoxTheme),
//                                               child: CheckboxListTile(
//                                                 value: value == option,
//                                                 activeColor: const Color(
//                                                   0xFF08CC1C,
//                                                 ),
//                                                 tileColor: kColorBlack,
//                                                 onChanged: (bool? newValue) {
//                                                   setState(
//                                                     () {
//                                                       selectedOption.value =
//                                                           option;
//                                                       isSelected = newValue!;
//                                                       if (isSelected = true) {
//                                                         _throwShotAway = false;
//                                                         log('${option}---------');

//                                                         // log(selectedOption
//                                                         //     .value);
//                                                         // fetchAnswers.add(answerOption!.first);

//                                                         sendAnswer =
//                                                             selectedOption
//                                                                 .value;
//                                                       }
//                                                     },
//                                                   );
//                                                   // fetchAnswers.removeLast();
//                                                 },
//                                                 title: Text(
//                                                   // 'True',
//                                                   option.toUpperCase(),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     )
//                                     .toList() ??
//                                 [],
//                           ),
//                         ),
//                       ),

//                       const YMargin(20),
//                       InkWell(
//                         onTap: () {
//                           log('${fetchAnswers.length} fetch answer lenght');
//                           log('${snapshot.data!.test!.data!.tests![0].questionTypes!.length} question lenght');
//                           // check if the user has selected any option
//                           if (fetchAnswers.length == 0) {
//                             fetchAnswers.add(sendAnswer);
//                           }

//                           if (isSelected || _throwShotAway) {
//                             fetchAnswers.add(sendAnswer);
//                             // if (fetchAnswers.length + 1 ==
//                             //     snapshot.data!.test!.data!.tests![0]
//                             //         .questionTypes!.length) {
//                             //   log('yes its equal mother and father fucker');
//                             //   setState(() {
//                             //     isSelected = false;
//                             //     fetchAnswers.add(sendAnswer +
//                             //         fetchAnswers.add(sendAnswer[0]));

//                             //     print(growableMap);
//                             //   });
//                             //   bool changeText = true;
//                             //  }
//                             print('${growableMap} item pushed');
//                             // fetchAnswers.add(sendAnswer);
//                             if (fetchAnswers.length <=
//                                 snapshot.data!.test!.data!.tests![0]
//                                     .questionTypes!.length) {
//                               // fetchAnswers.add(sendAnswer);
//                               print('${growableMap} log this too  pushed');
//                               nextPage();
//                               setState(() {
//                                 isSelected = false;
//                                 _throwShotAway = false;
//                                 selectedOption.value = '';
//                               });
//                               testId = snapshot.data?.test?.data?.tests?[0].sId;

//                               log('${snapshot.data!.test!.data!.tests![0].questionTypes!.length.toString()} total question lenght');
//                               log('${fetchAnswers.length} test Taken lenght');
//                             } else {
//                               // fetchAnswers.add(sendAnswer);
//                               nextPage();
//                               setState(() {
//                                 isSelected = false;
//                                 _throwShotAway = false;
//                                 selectedOption.value = '';
//                               });

//                               //fetchAnswers[totalPages] = sendAnswer;
//                               testResponse = growableMap;
//                               print(testResponse);
//                               //   log(testResponse);

//                               //  Send to Server
//                               log('in the else');
//                               // print(growableMap);
//                               // log(fetchAnswers.length.toString());
//                               // log(snapshot.data!.test!.data!.tests![0]
//                               //     .questionTypes!.length
//                               //     .toString());
//                               log(ChildsName.toString());
//                               log(Dob.toString());
//                               log(FilledBy.toString());
//                               model.sendAnswer(
//                                 TestAnswerModel(
//                                   testId: testId,
//                                   //   testId: "62a9acff5c8b4a31ad0d81ac",
//                                   // response: {
//                                   //   "1": false,
//                                   //   "2": false,
//                                   //   "3": false,
//                                   //   "4": true,
//                                   //   "5": false,
//                                   //   "6": true,
//                                   //   "7": false,
//                                   //   "8": false,
//                                   //   "9": true,
//                                   //   "10": false
//                                   // }
//                                   response: testResponse,
//                                   childDob: Dob.toString(),
//                                   childName: ChildsName.toString(),
//                                   filledBy: FilledBy.toString(),
//                                 ),
//                                 context,
//                               );

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) {
//                                   return Hurray(widget.sId);
//                                 }),
//                               );
//                             }
//                           }
//                         },
//                         child: Container(
//                           margin: context.insetsSymetric(
//                             horizontal: 15,
//                           ),
//                           width: double.infinity,
//                           padding: context.insetsOnly(top: 18, bottom: 17),
//                           decoration: BoxDecoration(
//                             color: isSelected || _throwShotAway
//                                 ? kColorMainPrimaryDark
//                                 : const Color(0xFFABABAB),
//                             borderRadius: BorderRadius.circular(
//                               context.scaleY(8),
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Next',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 color: kColorWhite,
//                                 fontSize: 14,
//                                 fontFamily: TRENDA_SEMI_BOLD,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const YMargin(20),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   gotoSelectedPage() {
//     if (_currentPage == 0) {
//       Future.delayed(
//         const Duration(seconds: 1),
//       ).then((value) => (value) {
//             _currentPage++;
//           });
//     }
//     _pageController.animateToPage(
//       _currentPage,
//       duration: const Duration(seconds: 2),
//       curve: Curves.easeIn,
//     );
//   }

//   void nextPage() {
//     _pageController.animateToPage(_pageController.page!.toInt() + 1,
//         duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
//   }

//   void previousPage() {
//     _pageController.animateToPage(_pageController.page!.toInt() - 1,
//         duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
//   }
// }