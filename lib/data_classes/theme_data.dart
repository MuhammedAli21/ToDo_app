import 'package:flutter/material.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData{
  static final ThemeData lightColor = ThemeData(
    primaryColor: AppColors.blueColor,
    scaffoldBackgroundColor: AppColors.lightBackGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blueColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.blueColor,
      unselectedItemColor: AppColors.grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor
      ),
      titleSmall: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor
      ),
      bodyMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
      bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.blueColor
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.blueColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),

        ),
      )
    )

  );

  static final ThemeData darkColor = ThemeData(
      primaryColor: AppColors.blueColor,
      scaffoldBackgroundColor: AppColors.blackBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: AppColors.grayColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.blackDarkColor
        ),
        titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
        ),
        titleSmall: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor
        ),
        bodyMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor
        ),
        bodySmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.blueColor
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.blueColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.blackDarkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          )
      )

  );

}