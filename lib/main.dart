import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/homeScreen.dart';
import 'package:music_app/screens/meteDataRetriver.dart';
import 'package:music_app/screens/songDownloadScreen.dart';

import 'Models/myRoute.dart';
import './screens/addSongScreen.dart';
import './screens/mySplashScreen.dart';
import './screens/optionScreen.dart';
import './themes/themeMode.dart';

void main() {
  runApp(const MusicListeningApp());
}

class MusicListeningApp extends StatelessWidget {
  const MusicListeningApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Listening App',
      theme: myThemeData(),

    home: const Scaffold(
        body: MySplashScreen(),
      ),
    routes: {
        MyRoute.addSongScreen: (context) => const AddSongScreen(),
        MyRoute.optionScreen: (context) => const OptionScreen(),
        MyRoute.homeScreen: (context) =>  const HomeScreen(),
        MyRoute.meta : (context) =>  const AudioMetadataScreen(),
        MyRoute.songDownloadScreen : (context) => const SongDownloadScreen(),
      },
    );
  }

}