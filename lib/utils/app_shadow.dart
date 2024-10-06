import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/appColors.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double BrRaduis = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? border,
}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(BrRaduis),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: sR,
            blurRadius: bR,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxShadowWithRaduis({
  Color color = AppColors.primaryElement,
  double BrRaduis = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? border,
}) {
  return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: sR,
            blurRadius: bR,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxDecorationTextField(
    {Color color = AppColors.primaryBackground,
    double BrRaduis = 15,
    Color borderColor = AppColors.primaryFourElementText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(BrRaduis),
      border: Border.all(color: borderColor));
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;

  const AppBoxDecorationImage(
      {super.key, this.width = 40, this.height = 40, this.imagePath = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage(imagePath)),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
