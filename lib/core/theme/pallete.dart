import 'package:flutter/material.dart';

class Pallete {
  //LightTheme
  ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: Colors.green,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    ),
  );

  //DarkTheme
  ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    //TileTheme
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
    ),
    primaryColor: Colors.green,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
  );
}
