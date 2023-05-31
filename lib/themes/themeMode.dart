 // ignore_for_file: file_names

 import 'package:flutter/material.dart';
import 'package:music_app/consts/colors.dart';

ThemeData myThemeData() {
    return ThemeData(
      fontFamily: "regular",
      primarySwatch: blueColor as MaterialColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0, 
      )
    );
  }
