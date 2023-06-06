// ignore_for_file: file_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../consts/colors.dart';
import 'homeScreen.dart';
class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: const HomeScreen(),
        image: Image.asset(
          "assets/images/logo.png ",
          fit: BoxFit.cover,
        ),
        backgroundColor: bgColor,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 150.0,
        loaderColor: whiteColor);
  }
}
