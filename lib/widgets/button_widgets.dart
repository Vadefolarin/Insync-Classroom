import 'package:flutter/material.dart';

import '../utils/appColors.dart';
import '../utils/app_shadow.dart';
import '../utils/text_widgets.dart';


Widget appButton({
  String text="text here", 
  Color color = Colors.white,
  double width = 325,
  double height = 50,
  bool isLogin=true,
  bool isBorder=false,
  void Function()? func,
  }) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width,
      height: height,
      decoration: appBoxShadow(
        color: isLogin? AppColors.primaryElement : Colors.white,
        border: isBorder ?Border.all(color: AppColors.primaryFourElementText ) : Border.all(color: Colors.transparent)
      ),
      child: Center(child: Text16Normal(text: text, color: color)),
    ),
  );
}