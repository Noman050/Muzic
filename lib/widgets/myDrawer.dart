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
              letterSpacing: 2,
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
          Navigator.pop(context);
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.settings, color: buttonColor,),
        title: const Text('Download Songs', style: TextStyle(color: whiteColor),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.lock, color:  buttonColor,),
        title: const Text('Lockscreen', style: TextStyle(color: whiteColor),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: white30Color),
      ListTile(
        leading: const Icon(Icons.more_horiz, color:  buttonColor,),
        title: const Text('Other', style: TextStyle(color: whiteColor),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color:white30Color),
      ListTile(
        leading: const Icon(Icons.switch_camera, color:  buttonColor,),
        title: const Text('Switch Screen Mode', style: TextStyle(color: whiteColor),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: white60Color),
      ListTile(
        leading: const Icon(Icons.home_max_outlined, color:  buttonColor,),
        title: const Text('Home Screen', style: TextStyle(color: whiteColor),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.optionScreen);
         
        },
      ),
    ]
  ),
);
  }
}