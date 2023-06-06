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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Card(
                elevation: 50,
                color: bgColor,
                child:  Text(
                  "Select One ",
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
                      minimumSize: const Size(190, 80),
                      backgroundColor: buttonColor),
                  icon: const Icon(Icons.add_to_drive, color: blackColor, size: 35,),
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoute.addSongScreen);
                  },
                  label: const Text(
                    "Add Song",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: blackColor),
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
                  icon: const Icon(Icons.music_note_outlined ,color: blackColor, size: 35, ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(190, 85),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoute.homeScreen);
                  },
                  label: const Text(
                    "Listen Songs",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: blackColor,),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Card(
                elevation: 50,
                color: bgColor,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.exit_to_app ,color: blackColor, size: 25, ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(110, 40),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  label: const Text(
                    "Exit",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: blackColor,),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: bgColor),
                onPressed: (){
                Navigator.of(context).pushNamed(MyRoute.meta);
              }, child:  const Text("Meta Data Test Screen"))
            ],
          ),
        ),
      ),
    );
  }
}
