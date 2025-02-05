import 'package:flutter/material.dart';

class Datawarna {
  static const Color primaryColor = Color(0xFF171717);
  static const Color secondaryColor = Color(0xFF262626);

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
  // primaryColor: const Color(0xFF0C5280),
  // primaryColorDark: Colors.blue[700],
  // primaryColorLight: Colors.blue[100],
);
