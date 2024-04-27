// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:music_app/consts/colors.dart';

ThemeData myThemeData() {
  return ThemeData(
      fontFamily: "bold",
      scaffoldBackgroundColor: bgDarkColor,
      buttonTheme: const ButtonThemeData(buttonColor: buttonColor),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: buttonColor),
        backgroundColor: bgColor,
        elevation: 10,
      ));
}
