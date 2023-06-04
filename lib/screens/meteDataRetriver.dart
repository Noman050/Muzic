// ignore_for_file: library_private_types_in_public_api, file_names, depend_on_referenced_packages

import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_app/consts/colors.dart';


class AudioMetadataScreen extends StatefulWidget {
  const AudioMetadataScreen({super.key});

  @override
  _AudioMetadataScreenState createState() => _AudioMetadataScreenState();
}

class _AudioMetadataScreenState extends State<AudioMetadataScreen> {
  File? _audioFile;
  String? _artist;
  String? _year;
  String? _album;
  String? _genre;

  Future<void> _selectAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      setState(() {
        _audioFile = File(result.files.single.path!);
      });
      final tagger = Audiotagger();
      final tags = await tagger.readTags(
        path: _audioFile!.path,
      );
      setState(() {
        _artist = tags?.artist;
        _year = tags?.year;
        _album = tags?.album;
        _genre = tags?.genre;
      });
    }
  }

  Future<void> _saveAudioFile() async {
    if (_audioFile != null) {
      final tagger = Audiotagger();
      await tagger.writeTags(
        tag: Tag(
          album: "Noman",
          artist: "Noman",
          year: 2022.toString(),
          genre: "Noman",
        ),
        path: _audioFile!.path,
      );
      // final directory = await getApplicationDocumentsDirectory();
      // await _audioFile!.copy("/storage/emulated/0/newSongs");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Metadata'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            if (_audioFile != null)
              Column(
                children: [
                  Text('Selected audio file: ${_audioFile!.path}'),
                
                    Column(
                      children: [
                        Text('Artist: $_artist'),
                        Text('Year of release: $_year'),
                        Text('Album of song: $_album'),
                        Text('Genre: $_genre'),
                      ],
                    ),
                ],
              ),
            ElevatedButton(
              onPressed: _selectAudioFile,
              child: const Text('Select audio file'),
            ),
            if (_audioFile != null)
              ElevatedButton(
                onPressed: _saveAudioFile,
                child: const Text('Save audio file'),
              ),
          ],
        ),
      ),
    );
  }
}