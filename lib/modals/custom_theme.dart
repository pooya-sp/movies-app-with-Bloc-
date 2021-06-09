import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 5.0,
      brightness: Brightness.light,
    ),
    canvasColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Colors.black,
    dividerColor: Colors.black54,
    splashColor: Colors.green,
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
  ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Color.fromRGBO(41, 82, 163, 0.3),
        elevation: 5.0,
        brightness: Brightness.dark),
    primaryColor: Color(0xFF141221),
    canvasColor: Color(0xFF141221),
    dividerColor: Colors.white,
    accentColor: Colors.red,
    scaffoldBackgroundColor: Color(0xFF141221),
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
    ),
    hintColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.white),
    cardTheme: CardTheme(
      color: Colors.black,
      shadowColor: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
