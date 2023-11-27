import 'package:flutter/material.dart';

class AppBarTheme1{

 static final theme1 = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Utiliza el color del tema aquí
    ),
  );

  static final theme2 = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black), // Utiliza el color del tema aquí
    ),
  );

}
