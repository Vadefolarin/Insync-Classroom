import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/utilities_service.dart';

class ParagraphText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final int? maxLines;

  const ParagraphText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.maxLines,
  }) : super(key: key);

  Color setThemeColor(bool isDarkMode) {
    if (color != null) {
      return color!;
    }
    return isDarkMode ? Colors.white : Colors.grey[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isDarkMode = ref.watch(themeProvider).darkMode;
      return RichText(
        maxLines: maxLines,
        softWrap: true,
        text: TextSpan(
          text: text,
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: setThemeColor(isDarkMode),
              fontSize: fontSize ?? 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        textAlign: TextAlign.left,
      );
    });
  }
}
