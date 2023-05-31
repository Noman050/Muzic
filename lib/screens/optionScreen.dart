// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Models/myRoute.dart';
import '../consts/colors.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              elevation: 50,
              color: bgColor,
              child:  Text(
                "Select One",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Card(
              elevation: 50,
              color:bgColor,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(250, 120),
                    backgroundColor: buttonColor),
                icon: const Icon(Icons.add_circle_outlined),
                onPressed: () {
                  Navigator.of(context).pushNamed(MyRoute.addSongScreen);
                },
                label: const Text(
                  "Add Song",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              elevation: 50,
              color: bgColor,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.music_note_outlined),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(250, 120),
                  backgroundColor: buttonColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(MyRoute.homeScreen);
                },
                label: const Text(
                  "Listen Songs",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 50,
              color: bgColor,
              child: TextButton.icon(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: const Icon(Icons.exit_to_app, color: whiteColor),
                  label: const Text("Exit",
                      style: TextStyle(
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),),),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(MyRoute.meta);
            }, child: const Text("Meta"))
          ],
        ),
      ),
    );
  }
}
