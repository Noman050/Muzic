// ignore_for_file: file_names
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../Models/myRoute.dart';
import '../consts/colors.dart';
import '../controllers/playerController.dart';
import '../screens/playerScreen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {


    Future<void> selectAudioFile() async {

    await FilePicker.platform.pickFiles(
      type: FileType.audio,

    );
    }

    return Drawer(
      shadowColor: buttonColor,
      backgroundColor: bgColor,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color:  bgColor,
        ),
        child: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: whiteColor,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.audiotrack, color: buttonColor,),
        title: const Text('Audio', style: TextStyle(color: whiteColor),),
        onTap: () {
          selectAudioFile();
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.settings, color: buttonColor,),
        title: const Text('Settings Screen', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.settingsScreem);
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.description , color:  buttonColor,),
        title: const Text('Check Report', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
            Navigator.of(context).pushNamed(MyRoute.reportScreen);
            }
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.library_music, color:  buttonColor,),
        title: const Text('Add Song', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.addSongScreen);
        },
      ),
      const Divider(color: white60Color),
      ListTile(
        leading: const Icon(Icons.add_to_home_screen_rounded, color:  buttonColor,),
        title: const Text('Option Screen', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.optionScreen);
         
        },
      ),
      const Divider(color: white30Color),
      ListTile(
              leading: const Icon(Icons.info, color: buttonColor,),
              title: const Text('App Version', style: TextStyle(color: whiteColor)  ),
              subtitle: const Text('1.0.0', style: TextStyle(color: whiteColor),),
              onTap: () {
              },
            ),
      const Divider(color: white30Color),
    ]
  ),
);
  }
}