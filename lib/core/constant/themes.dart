import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final lightTheme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.whiteColor),
  primaryColor: AppColors.primaryColor,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    centerTitle: true,
    elevation: 4,
    systemOverlayStyle: SystemUiOverlayStyle(),
    actionsIconTheme: IconThemeData(),
    foregroundColor: AppColors.whiteColor,
  ),
  textTheme: const TextTheme(),
);

final darkTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  brightness: Brightness.dark,
);
