import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBgColor = Color(0xff121312);
  static const Color lightGrayColor = Color(0xffC6C6C6);
  static const Color mediumGrayColor = Color(0xffB5B4B4);
  static const Color darkGrayColor = Color(0xff282A28);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color yellowColor = Color(0xffFFBB3B);
  static const Color dividerColor = Color(0xff707070);
  static const Gradient yellowGradientColor = LinearGradient(colors: [Color(0xffFFBB3B) , Color(0xffFFA90A)]);
  static const Color grayColor = Color(0xff514F4F);
}

class TextColors{
  static const Color textLightColor = AppColors.whiteColor;
  static const Color textMediumGrayColor = AppColors.mediumGrayColor;
}

class IconsColors{
  static const Gradient iconLightColor = AppColors.yellowGradientColor;
  static const Color iconLightColorYellow = AppColors.yellowColor;
  static const Color iconMediumGrayColor = AppColors.mediumGrayColor;
  static const Color iconDarkGrayColor = AppColors.darkGrayColor;
  static const iconBlackColor = AppColors.blackColor;
}

class ButtonColors {
  static const Color buttonDarkColor = AppColors.darkGrayColor;
  static const Color buttonLightColor = AppColors.whiteColor;
  static const Color buttonLightGrayColor = AppColors.lightGrayColor;
}
