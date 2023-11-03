// app_themes.dart

import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData profileTheme(bool isEditable) {
    Color underlineColor =
        isEditable ? const Color.fromARGB(255, 13, 170, 167) : Color.fromARGB(255, 195, 32, 32);
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 243, 237, 230),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underlineColor,
            width: 2.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 13, 170, 167),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
