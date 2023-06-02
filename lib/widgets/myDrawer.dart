// ignore_for_file: file_names
import "package:flutter/material.dart";
import '../Models/myRoute.dart';
import '../consts/colors.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
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
          // Update the state of the app
          // ...
          // Then close the drawer
       
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.settings, color: buttonColor,),
        title: const Text('Download Songs', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.meta);
          // Update the state of the app
          // ...
          // Then close the drawer
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.lock, color:  buttonColor,),
        title: const Text('Lockscreen', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.library_music, color:  buttonColor,),
        title: const Text('Add Song', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.of(context).pushNamed(MyRoute.addSongScreen);
        },
      ),
      const Divider(color: white60Color),
      ListTile(
        leading: const Icon(Icons.add_to_home_screen_rounded, color:  buttonColor,),
        title: const Text('Option Screen Screen', style: TextStyle(color: whiteColor, letterSpacing: 1),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.optionScreen);
         
        },
      ),
    ]
  ),
);
  }
}