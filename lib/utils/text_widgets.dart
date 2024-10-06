import 'package:flutter/material.dart';

import '../utils/appColors.dart';

Widget Text24Normal(
    {required String text, Color color = AppColors.primaryText, FontWeight weight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 24, fontWeight: weight),
  );
}

// Widget Text16Normal(
//     {required String text,
//     Color color = AppColors.primarySecondaryElementText}) {
//   return Text(
//     text,
//     textAlign: TextAlign.center,
//     style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.normal),
//   );
// }

class Text16Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  const Text16Normal({super.key, this.text="", this.color= AppColors.primarySecondaryElementText, this.fontWeight= FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 16, fontWeight: fontWeight),
  );
  }
}

class Text12Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  const Text12Normal({super.key, this.text="", this.color= AppColors.primarySecondaryElementText, this.fontWeight= FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 12, fontWeight: fontWeight),
  );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  final bool isCenter;

  const Text14Normal({super.key, required this.text, required this.color, required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return Text(
    text,
    textAlign: isCenter ? TextAlign.center : TextAlign.start,
    style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.normal),
  );
  }
}

Widget TextUnderline({String text = "", Color color = AppColors.primaryText, Color underlineColors = AppColors.primaryText}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        color: color,
        decoration: TextDecoration.underline,
        decorationColor: underlineColors,
        fontWeight: FontWeight.normal,
        fontSize: 12
        ),
    ),
  );
}
