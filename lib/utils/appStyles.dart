import 'package:flutter/material.dart';

import 'appColors.dart';

const smallTextScaleFactor = 1.00;
const largeTextScaleFactor = 1.10;

class AppTheme {
  static ThemeData appThemeData = ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.primaryText)));
}
