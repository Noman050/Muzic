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
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      const Divider(color: Colors.white30),
      ListTile(
        leading: const Icon(Icons.audiotrack, color: Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Audio', style: TextStyle(color: Colors.white),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: Colors.white30),
      ListTile(
        leading: const Icon(Icons.settings, color: Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Advanced', style: TextStyle(color: Colors.white),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: Colors.white30),
      ListTile(
        leading: const Icon(Icons.lock, color:  Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Lockscreen', style: TextStyle(color: Colors.white),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: Colors.white30),
      ListTile(
        leading: const Icon(Icons.more_horiz, color:  Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Other', style: TextStyle(color: Colors.white),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: Colors.white30),
      ListTile(
        leading: const Icon(Icons.switch_camera, color:  Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Switch Screen Mode', style: TextStyle(color: Colors.white),),
        onTap: () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      const Divider(color: Colors.white60),
      ListTile(
        leading: const Icon(Icons.home_max_outlined, color:  Color.fromRGBO(225, 100, 143, 1.0),),
        title: const Text('Home Screen', style: TextStyle(color: Colors.white),),
        onTap: () {
          Navigator.of(context).pushNamed(MyRoute.optionScreen);
         
        },
      ),
    ]
  ),
);
  }
}