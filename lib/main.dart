import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/homeScreen.dart';
import 'package:music_app/screens/meteDataRetriever.dart';
import 'package:music_app/screens/settingsScreen.dart';

import 'Models/myRoute.dart';
import './screens/addSongScreen.dart';
import './screens/mySplashScreen.dart';
import './screens/optionScreen.dart';
import './themes/themeMode.dart';
import 'screens/weeklyReportScreen.dart';

void main() {
  runApp(const MusicListeningApp());
}

class MusicListeningApp extends StatelessWidget {
  const MusicListeningApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muzic',
      theme: myThemeData(),
      home: const Scaffold(
        body: MySplashScreen(),
      ),
      routes: {
        MyRoute.addSongScreen: (context) => const AddSongScreen(),
        MyRoute.optionScreen: (context) => const OptionScreen(),
        MyRoute.homeScreen: (context) => const HomeScreen(),
        MyRoute.meta: (context) => const AudioMetadataScreen(),
        MyRoute.settingsScreen: (context) => const SettingsScreen(),
        MyRoute.reportScreen: (context) => WeeklyReportScreen(),
      },
    );
  }
}
