import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // primaryColor: const Color.fromARGB(255, 35, 137, 195),
    scaffoldBackgroundColor: const Color.fromARGB(255, 238, 231, 228),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 102, 93, 93), // text color
      onPrimary: Colors.pinkAccent,
      onSurface: Color.fromARGB(255, 117, 102, 102), // for  color in hint text or hover faile if foucus
      surface: Color.fromARGB(255, 159, 214, 246), // for baground btn
      primaryContainer: Color.fromARGB(255, 245, 210, 193),
      secondary: Color(0xFFC9D6DF),
      secondaryContainer: Color.fromARGB(255, 165, 191, 210),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ).copyWith(secondary: const Color(0xFFFFE5D9)),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 255, 158, 113),
      onPrimary: Color.fromARGB(255, 144, 143, 143),
      primaryContainer: Color.fromARGB(255, 253, 137, 80),
      secondary: Color.fromARGB(255, 82, 147, 194),
      secondaryContainer: Color.fromARGB(255, 91, 133, 162),
      onSecondary: Color.fromARGB(255, 243, 243, 243),
      surface: Color.fromARGB(255, 0, 0, 0),
      onSurface: Color.fromARGB(255, 169, 175, 179),
      error: Color.fromARGB(255, 173, 35, 25),
      onError: Colors.white,
    ).copyWith(secondary: const Color.fromARGB(255, 250, 135, 82)),
  );
}
