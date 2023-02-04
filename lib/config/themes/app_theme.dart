import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/utils/app_strings.dart';

ThemeData appData() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.hintColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.wColor,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.noColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.bKColor,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        height: 1.3,
        fontSize: 22,
        color: AppColors.wColor,
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        color: AppColors.bKColor,
        fontWeight: FontWeight.w500,
      ),
      headline1: TextStyle(
        color: AppColors.bKColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      //hint text 
      headline2: TextStyle(
        color: AppColors.hintColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
