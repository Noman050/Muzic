// ignore_for_file: file_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../consts/colors.dart';
import '../screens/optionScreen.dart';
class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: const OptionScreen(),
        image: Image.asset(
          "assets/images/logo.jpg",
          fit: BoxFit.cover,
        ),
        backgroundColor: splashColor,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 70.0,
        loaderColor: whiteColor);
  }
}
