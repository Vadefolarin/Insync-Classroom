// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:insync/utils/colors.dart';
// import 'package:insync/views/authentication/signUp/signUp.dart';

// class ChooseAccount extends ConsumerStatefulWidget {
//   const ChooseAccount({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
// }

// class _SignUpState extends ConsumerState<ChooseAccount> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kcolorbackgrounddark,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Continue Your learning  with Insync Classroom',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: kcolorMainPrimary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 50),
//                   InContainer(
//                     text: 'Sign up as a tutor',
//                     icon: 'assets/icons/tutor.svg',
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const SignUp();
//                       }));
//                     },
//                   ),
//                   const SizedBox(height: 50),
//                   InContainer(
//                     text: 'Sign up as a student',
//                     icon: 'assets/icons/student.svg',
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const SignUp();
//                       }));
//                     },
//                   ),
//                   const SizedBox(height: 50),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InContainer extends StatelessWidget {
//   const InContainer({
//     super.key,
//     required this.text,
//     required this.icon,
//     this.onTap,
//   });
//   final String text;
//   final String icon;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF333333),
//           borderRadius: BorderRadius.circular(10),
//           //TODO: change color ONTAP
//           border: Border.all(color: kcolorMainPrimary, width: 4),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 21),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SvgPicture.asset(
//               icon,
//               fit: BoxFit.scaleDown,
//               height: 25,
//               width: 25,
//             ),
//             Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
