import 'package:flutter/material.dart';

class Datawarna {
  static const Color primaryColor = Color.fromARGB(255, 35, 221, 245);
  static const Color secondaryColor = Color.fromARGB(255, 255, 123, 0);
  static const Color tertiaryColor = Color.fromARGB(255, 214, 112, 34);
  static const Color hitam = Colors.black;
  static const Color putih = Colors.white;
  static Color abu = Colors.black.withOpacity(0.7);

  static const Color bg = Color.fromARGB(255, 244, 251, 255);

  static const LinearGradient warnaGradasi = LinearGradient(colors: []);
}

var theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: const Color(0xFFF5F5F7),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 238, 249, 255),
    foregroundColor: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: Datawarna.tertiaryColor,
    suffixIconColor: Datawarna.tertiaryColor,
  ),
  
);
