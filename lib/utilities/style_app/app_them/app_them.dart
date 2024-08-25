import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // primaryColor: const Color(0xFFE7ECEF),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 30, 30, 206),
      onPrimary: Colors.white,
      primaryContainer: Color.fromARGB(255, 245, 210, 193),
      secondary: Color(0xFFC9D6DF),
      secondaryContainer: Color.fromARGB(255, 165, 191, 210),
      onSecondary: Colors.black,
      surface: Color.fromARGB(255, 194, 220, 235),
      onSurface: Color.fromARGB(255, 110, 120, 125),
      error: Colors.red,
      onError: Colors.white,
    ).copyWith(secondary: const Color(0xFFFFE5D9)),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 255, 158, 113),
      onPrimary: Color.fromARGB(255, 144, 143, 143),
      primaryContainer: Color.fromARGB(255, 253, 137, 80),
      secondary: Color.fromARGB(255, 82, 147, 194),
      secondaryContainer: Color.fromARGB(255, 91, 133, 162),
      onSecondary: Color.fromARGB(255, 243, 243, 243),
      surface: Color.fromARGB(255, 0, 0, 0),
      onSurface: Color.fromARGB(255, 110, 120, 125),
      error: Color.fromARGB(255, 173, 35, 25),
      onError: Colors.white,
    ).copyWith(secondary: const Color.fromARGB(255, 250, 135, 82)),
  );
}

