import 'package:flutter/material.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        //fontFamily: 'Mulish',
        // primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        shadowColor: const Color(0xFF110C2E).withValues(alpha: 0.15),
        inputDecorationTheme: InputDecorationTheme(
          helperStyle: TextStyle(
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFCCCCCC),
            ),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(
          //     color: AppColors.errorColor,
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFCCCCCC),
            ),
          ),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          bodyLarge: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          displayLarge: TextStyle(
            color: AppColors.blackColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: const TextStyle(color: Colors.white),
          labelLarge: TextStyle(
            color: AppColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.46,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,

        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
       //fontFamily: 'Mulish',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: const MaterialColor(
          0xFFFFFFFF,
          {
            50: Color(0xFFFFFFFF),
            100: Color(0xFFFFFFFF),
            200: Color(0xFFFFFFFF),
            300: Color(0xFFFFFFFF),
            400: Color(0xFFFFFFFF),
            500: Color(0xFFFFFFFF),
            600: Color(0xFFFFFFFF),
            700: Color(0xFFFFFFFF),
            800: Color(0xFFFFFFFF),
            900: Color(0xFFFFFFFF),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFF000000),
          ),
        ),
      );
}
