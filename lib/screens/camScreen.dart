// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:music_app/consts/colors.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      e.toString();
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    try {
      XFile? file = await cameraController.takePicture();
      if (file.path.isNotEmpty) {
        await savePicture(file.path);
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> savePicture(String imagePath) async {
    try {
      final File imageFile = File(imagePath);

      if (!imageFile.existsSync()) {
        throw Exception("Image file does not exist at path: $imagePath");
      }
      const String galleryPath = '/storage/emulated/0/DCIM/Camera';
      final String newImagePath = '$galleryPath/${path.basename(imagePath)}';

      final Directory galleryDirectory = Directory(galleryPath);
      if (!galleryDirectory.existsSync()) {
        galleryDirectory.createSync(recursive: true);
      }

      await imageFile.copy(newImagePath);
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: buttonColor,
            backgroundColor: bgColor,
          ),
        ),
      );
    } else if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  initializeCamera();
                });
              },
              child: _buildButton(
                  Icons.flip_camera_android, Alignment.bottomRight),
            ),
            GestureDetector(
              onTap: takePicture,
              child: _buildButton(Icons.camera, Alignment.bottomCenter),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  initializeCamera();
                });
              },
              child: _buildButton(
                  Icons.flip_camera_android_outlined, Alignment.bottomLeft),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildButton(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: blackColor,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
