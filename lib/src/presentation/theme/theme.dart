import 'package:flutter/material.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

final AppTheme = ThemeData(
  canvasColor: Colors.transparent,
  focusColor: AppColors.primary,
  brightness: Brightness.dark,
  accentColor: AppColors.black,
  primaryColor: AppColors.primary,
  primarySwatch: MaterialColor(0xFFECA301, const {
    50: AppColors.primary,
    100: AppColors.primary,
    200: AppColors.primary,
    300: AppColors.primary,
    400: AppColors.primary,
    500: AppColors.primary,
    600: AppColors.primary,
    700: AppColors.primary,
    800: AppColors.primary,
    900: AppColors.primary,
  }),
  scaffoldBackgroundColor: AppColors.background,
  backgroundColor: AppColors.background,
  cardColor: AppColors.black,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(0),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: AppColors.white, fontSize: 16),
    bodyText2: TextStyle(color: AppColors.white, fontSize: 16),
  ),
);
