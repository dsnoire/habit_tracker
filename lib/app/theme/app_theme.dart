import "package:flutter/material.dart";
import "package:habit_tracker/app/colors/app_colors.dart";

class AppTheme {
  static final theme = ThemeData(
    fontFamily: 'Montserrat',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.white,
      secondary: AppColors.white,
      onSurface: AppColors.white,
      onSurfaceVariant: AppColors.grey,
      onSecondary: AppColors.white,
      tertiary: Colors.blue,
      onTertiary: Colors.yellow,
      surface: AppColors.darkGrey,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.darkGrey,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
