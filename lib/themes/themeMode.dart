 // ignore_for_file: file_names

 import 'package:flutter/material.dart';

ThemeData myThemeData() {
    return ThemeData(
      fontFamily: "regular",
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0, 
      )
    );
  }
