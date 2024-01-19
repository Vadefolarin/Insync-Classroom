// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';


// class MuteText extends StatelessWidget {
//   final String text;
//   final Color? color;

//   const MuteText({
//     Key? key,
//     required this.text,
//     this.color,
//   }) : super(key: key);

//   Color setThemeColor(bool isDarkMode) {
//     if (color != null) return color!;
//     return isDarkMode ? Colors.white : Colors.black;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, child) {
//       // final isDarkMode = ref.watch(themeProvider).darkMode;
//       return Text(
//         text,
//         style: GoogleFonts.mulish(
//           textStyle: TextStyle(
//             color: setThemeColor(isDarkMode),
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//       );
//     });
//   }
// }