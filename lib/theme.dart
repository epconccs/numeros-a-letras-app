import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/constants.dart';

class AppTheme {
  static ThemeData get nalTheme {
    return ThemeData(
      fontFamily: 'Avenir',
      colorScheme: const ColorScheme.light(
        primary: AppColors.nalLightGreen,
      ),
      scaffoldBackgroundColor: AppColors.nalBackground,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.nalLightGreen,
        ),
        hintStyle: TextStyle(
          color: AppColors.nalLightGreen,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.nalLightGreen),
        ),
      ),
    );
  }
}
