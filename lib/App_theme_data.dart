import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/App_colors.dart';

class AppThemeData {
  static ThemeData light_theme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.green_color,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        borderSide: BorderSide(color: AppColors.green_color),
      ),
      titleTextStyle: GoogleFonts.exo(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.white_color,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.white_color,
        size: 35,
      ),    )
      ,
    iconTheme: IconThemeData(
      color: AppColors.black_color,
      size: 30
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.dark_gray,
      ),
      titleMedium:  GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.light_gray,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.light_gray,
      ),
      labelLarge:GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.dark_gray
      ),
      labelMedium: GoogleFonts.exo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge:  GoogleFonts.exo(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.white_color
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.black_color
      )
    )
  );
}
