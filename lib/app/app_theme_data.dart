import 'package:famconnect/app/app_colors.dart';
import 'package:flutter/material.dart';


class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.themeColor,
        ),
      ),
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: const Color(0xFF121212),
      brightness: Brightness.dark,

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black12,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
