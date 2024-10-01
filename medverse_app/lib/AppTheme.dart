import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF6d4dd3),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF6d4dd3),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF041f30)),
        bodyMedium: TextStyle(color: Color(0xFF041f30)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6d4dd3),
        ),
      ),
    );
  }
}