import 'package:flutter/material.dart';
import 'package:plumedica/helper/colors.dart';
class AppThemeData {
  AppThemeData._();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: Color(0xff939393),
      suffixIconColor: Color(0xff939393),
      labelStyle: const TextStyle().copyWith(fontSize: 16.0, color: Color(0xFF232323)),
      hintStyle: const TextStyle().copyWith(fontSize: 14.0, color: Color(0xFF232323)),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle().copyWith(color: Color(0xFF232323).withValues(alpha: 0.8)),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(width: 1, color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(width: 1, color: Color(0xFFE0E0E0)),
      ),
      focusedBorder:const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(width: 1, color: Color(0xFF272727)),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(width: 1, color: TAppColors.primaryColor),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(width: 2, color: TAppColors.primaryColor,
        ),
      ));

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
    ),
  );

}