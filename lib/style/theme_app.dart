import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme{
static final ThemeData mainTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkBgColor,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.cairo(
      color: TextColors.textLightColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.cairo(
      color: TextColors.textMediumGrayColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.cairo(
      color: TextColors.textLightColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.cairo(
      color: TextColors.textMediumGrayColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.cairo(
      color: TextColors.textLightColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.darkGrayColor,
    selectedItemColor: AppColors.yellowGradientColor.colors[0],
    unselectedItemColor: AppColors.lightGrayColor,


  ),
);
}