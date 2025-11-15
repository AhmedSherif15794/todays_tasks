import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todays_tasks/utils/app_colors.dart';
import 'package:todays_tasks/utils/app_functions.dart';
import 'package:todays_tasks/utils/app_styles.dart';

class AppTheme {
  // light
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    primaryColor: AppColors.lightPrimaryColor,
    primaryColorDark: AppColors.lightTextPrimaryColor,
    cardColor: AppColors.white,
    hintColor: AppColors.darkTextSecondaryColor,
    indicatorColor: AppColors.lightSecondaryColor,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: AppColors.lightPrimaryColor,
        foregroundColor: AppColors.white,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: AppFunctions.inputBorder(
        borderColor: AppColors.darkTextSecondaryColor,
        radius: 8.r,
      ),
      enabledBorder: AppFunctions.inputBorder(
        borderColor: AppColors.darkTextSecondaryColor,
        radius: 8.r,
      ),
      focusedBorder: AppFunctions.inputBorder(
        borderColor: AppColors.lightTextSecondaryColor,
        radius: 8.r,
      ),
      errorBorder: AppFunctions.inputBorder(
        borderColor: AppColors.red,
        radius: 8.r,
      ),
      hintStyle: AppStyles.medium16darkGrey,
    ),

    textTheme: TextTheme(
      headlineLarge: AppStyles.bold24Black,
      headlineMedium: AppStyles.bold20Black,
      headlineSmall: AppStyles.bold16Black,
      bodyLarge: AppStyles.medium20Black,
      bodyMedium: AppStyles.medium18Black,
      bodySmall: AppStyles.medium16Black,
      labelLarge: AppStyles.medium22darkGrey,
      labelMedium: AppStyles.medium20darkGrey,
      labelSmall: AppStyles.medium16darkGrey,
    ),
  );

  // dark
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    primaryColor: AppColors.darkPrimaryColor,
    primaryColorDark: AppColors.darkTextPrimaryColor,
    cardColor: AppColors.darkSurfaceColor,
    hintColor: AppColors.darkTextSecondaryColor,
    indicatorColor: AppColors.darkSecondryColor,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: AppColors.darkPrimaryColor,
        foregroundColor: AppColors.black,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: AppFunctions.inputBorder(
        borderColor: AppColors.darkTextSecondaryColor,
        radius: 8.r,
      ),
      enabledBorder: AppFunctions.inputBorder(
        borderColor: AppColors.darkTextSecondaryColor,
        radius: 8.r,
      ),
      focusedBorder: AppFunctions.inputBorder(
        borderColor: AppColors.darkPrimaryColor,
        radius: 8.r,
      ),
      errorBorder: AppFunctions.inputBorder(
        borderColor: AppColors.red,
        radius: 8.r,
      ),
      hintStyle: AppStyles.medium16darkGrey,
    ),

    textTheme: TextTheme(
      headlineLarge: AppStyles.bold24White,
      headlineMedium: AppStyles.bold20White,
      headlineSmall: AppStyles.bold16White,
      bodyLarge: AppStyles.medium20White,
      bodyMedium: AppStyles.medium18White,
      bodySmall: AppStyles.medium16White,
      labelLarge: AppStyles.medium22darkGrey,
      labelMedium: AppStyles.medium20darkGrey,
      labelSmall: AppStyles.medium16darkGrey,
    ),
  );
}
