import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

final ThemeData shopTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: SphereShopColors.white,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w600,
      fontFamily: 'Mulish',
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Mulish',
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'Mulish',
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontFamily: 'Mulish',
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: SphereShopColors.primaryColor,
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Mulish',
        color: SphereShopColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
);
//const Color(0xFFEEF1F4),