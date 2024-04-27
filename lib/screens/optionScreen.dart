// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Models/myRoute.dart';
import '../consts/colors.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission(Permission.storage);
  }

  Future<bool> requestPermission(Permission permission) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 120),
              Card(
                elevation: 50,
                color: bgColor,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(180, 50),
                      backgroundColor: buttonColor),
                  icon: const Icon(
                    Icons.add_to_drive,
                    color: blackColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoute.addSongScreen);
                  },
                  label: const Text(
                    "Add Songs",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 50,
                color: bgColor,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.music_note_outlined,
                    color: blackColor,
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(180, 50),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoute.homeScreen);
                  },
                  label: const Text(
                    "Play Songs",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 50,
                color: bgColor,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.check_box,
                    color: blackColor,
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(180, 50),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    openAppSettings();
                  },
                  label: const Text(
                    "Permissions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 50,
                color: bgColor,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: blackColor,
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(180, 50),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  label: const Text(
                    "Exit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
