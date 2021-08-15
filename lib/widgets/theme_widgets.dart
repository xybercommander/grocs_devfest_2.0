// @dart=2.9
import 'package:flutter/material.dart';
import 'package:grocs/utils/colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  accentColor: AppColors.lightTheme,
  textTheme: TextTheme(
    title: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
    subtitle: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
    subhead: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
  )
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.darkTheme,
  accentColor: AppColors.lightTheme,
  textTheme: TextTheme(
    title: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
    subtitle: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
    subhead: TextStyle(fontFamily: 'Nunito-SemiBold',color: AppColors.lightTheme),
  )
);