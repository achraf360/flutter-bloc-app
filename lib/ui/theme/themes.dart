import 'package:flutter/material.dart';

class CustomThemes {
  static TextStyle errorTextStyle =
      const TextStyle(fontSize: 22, color: Colors.red);
  static List<ThemeData> themes = [
    ThemeData(
      primaryColor: Colors.deepOrange,
      iconTheme: IconThemeData(color: Colors.deepOrange),
    ),
    ThemeData(
      primaryColor: Colors.indigo,
      iconTheme: IconThemeData(color: Colors.indigo),
    ),
    ThemeData(
      primaryColor: Colors.brown,
      iconTheme: IconThemeData(color: Colors.brown),
    ),
  ];
}
