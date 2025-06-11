import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Color(0xFF6C63FF),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF5F5F5),
      labelStyle: TextStyle(color: Color(0xFF324F5E)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Color(0xFF324F5E),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Color(0xFF324F5E)),
      labelMedium: TextStyle(color: Color(0xFF96A7AF)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF6C63FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
}
