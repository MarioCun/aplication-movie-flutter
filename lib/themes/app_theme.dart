import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.grey;

  static final ThemeData dartTheme = ThemeData.dark().copyWith(
    //color primario
    primaryColor: primary,
    //appbar theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
  );
}
