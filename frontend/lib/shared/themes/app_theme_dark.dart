import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemeDark {
  // function for border decoration
  static _border([Color color = AppColors.surfaceDark30]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(14),
  );

  static final appDarkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark10,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surfaceDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      // filled: true,
      // fillColor: AppColors.surfaceDark10,
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.primary10),
      hintStyle: TextStyle(color: AppColors.surfaceDark50, fontSize: 12),
    ),
  );
}
