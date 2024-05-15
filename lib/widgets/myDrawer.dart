// ignore_for_file: file_names
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import '../Models/myRoute.dart';
import '../consts/colors.dart';
import '../screens/camScreen.dart';

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

    Future<bool> _checkPer(Permission permission) async {
      AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
      if (build.version.sdkInt >= 30) {
        var re = await Permission.manageExternalStorage.request();
        if (re.isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        if (await permission.isGranted) {
          return true;
        } else {
          var result = await permission.request();
          if (result.isGranted) {
            return true;
          } else {
            return false;
          }
        }
      }
    }

    return Drawer(
      backgroundColor: bgColor,
      child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: bgColor,
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
          leading: const Icon(
            Icons.audiotrack,
            color: buttonColor,
          ),
          title: const Text(
            'Audio',
            style: TextStyle(color: whiteColor),
          ),
          onTap: () {
            selectAudioFile();
          },
        ),
        const Divider(color: white30Color),
        ListTile(
          leading: const Icon(
            Icons.settings,
            color: buttonColor,
          ),
          title: const Text(
            'Settings Screen',
            style: TextStyle(color: whiteColor, letterSpacing: 1),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(MyRoute.settingsScreen);
          },
        ),
        const Divider(color: white30Color),
        ListTile(
            leading: const Icon(
              Icons.description,
              color: buttonColor,
            ),
            title: const Text(
              'Check Report',
              style: TextStyle(color: whiteColor, letterSpacing: 1),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(MyRoute.reportScreen);
            }),
        const Divider(color: white30Color),
        ListTile(
          leading: const Icon(
            Icons.library_music,
            color: buttonColor,
          ),
          title: const Text(
            'Add Song',
            style: TextStyle(color: whiteColor, letterSpacing: 1),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(MyRoute.addSongScreen);
          },
        ),
        const Divider(color: white60Color),
        ListTile(
          leading: const Icon(
            Icons.add_to_home_screen_rounded,
            color: buttonColor,
          ),
          title: const Text(
            'Option Screen',
            style: TextStyle(color: whiteColor, letterSpacing: 1),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(MyRoute.optionScreen);
          },
        ),
      ]),
    );
  }
}
