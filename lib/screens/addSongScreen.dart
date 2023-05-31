// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:music_app/consts/colors.dart';
import '../consts/sizedBox10.dart';


class AddSongScreen extends StatefulWidget {
  const AddSongScreen({super.key});
  @override
  MetadataSelectionState createState() => MetadataSelectionState();
}

class MetadataSelectionState extends State<AddSongScreen> {
  File? _audioFile;
  String? _selectedArtist;
  String _selectedYear = "2000";
  String _selectedAlbum = "Mustt Mustt";
  String _selectedGenre = "Rock";
  // String _selectedTempo = "Slow";

  final List<String> _artists = ["Nusrat Fateh Ali Khan","Rahet Fateh Ali Khan","Sahir Ali Bagga","Atif Aslam","Bilal Saeed","Aima Baig"];
  final List<String> _years = ["2000", "2001", "2002","2003","2004","2005"];
  final List<String> _albums = ["Mustt Mustt", "Age 19", "New Born","New Sing","Dubai Da Sheikh","Husn Mehal"];
  final List<String> _genres = [
    "Rock",
    "Folk",
    "Pop",
    "Jazz",
    "Classical",
    "Hip Hop"
  ];
  // final List<String> _tempos = [
  //   "Slow",
  //   "Mildly Slow",
  //   "Moderate",
  //   "Slightly Fast",
  //   "Fast"
  // ];

  void _addArtist(String name) {
    setState(() {
      _artists.add(name);
    });
  }

  void _addAlbum(String albumName) {
    setState(() {
      _albums.add(albumName);
    });
  }

  void _addYear(String year) {
    setState(() {
      _years.add(year);
    });
  }

  void _addNewSong() {
    setState(() {
      _selectedArtist =
          _artists.firstWhere((artist) => artist == _selectedArtist);
      _selectedYear = _years.firstWhere((year) => year == _selectedYear);
      _selectedAlbum = _albums.firstWhere((album) => album == _selectedAlbum);
      _selectedGenre = _genres.firstWhere((genre) => genre == _selectedGenre);
      // _selectedTempo = _tempos.firstWhere((tempo) => tempo == _selectedTempo);
    });
    _saveAudioFile();
  }

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
        _selectedArtist = tags?.artist as String;
        _selectedYear = tags?.year as String;
        _selectedGenre = tags?.genre as String;
        _selectedAlbum = tags?.album as String;
      });
    }
  }
  Future<void> _saveAudioFile() async {
    if (_audioFile != null) {
      final tagger = Audiotagger();
      await tagger.writeTags(
        tag: Tag(
          artist: _selectedArtist,
          year: _selectedYear,
          genre: _selectedGenre,
          album: _selectedAlbum,
        ),
        path: _audioFile!.path,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Meta Data Added Successfully")),
      );

    }
  }

  TextStyle myTextStyle(Color color) {
    return TextStyle(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: const Text("Add Song"),
      ),
      body: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: <Widget>[
            Text(
              'Select Artists',
              style: myTextStyle(whiteColor),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: DropdownButton<String>(
                hint: const Text("Select Artist"),
                items: _artists.map((String value) {
                  return DropdownMenuItem<String>(
                  
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedArtist = newValue!;
                  });

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 90),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    backgroundColor: buttonColor,),
                icon: const Icon(Icons.group_add_outlined),
                label: const Text('Add Artist'),
                onPressed: () {
                  String newtext = "";
                  showDialog(
                    barrierColor: bgColor,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Artist'),
                        content: TextField(
                          cursorColor: buttonColor,
                          autofocus: true,
                          onChanged: (text) {
                            setState(() {
                              newtext = text;
                            });
                          },
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                            child: const Text('Done'),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _addArtist(newtext.toString());
                              });
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Text('Select Year of Release', style: myTextStyle(whiteColor)),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: DropdownButton<String>(
                hint: const Text('Select Year'),
               // value: _selectedYear,
                items: _years.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                     _selectedYear = newValue!;
                  });
                 
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 90),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.date_range_outlined),
                label: const Text('Add Year'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    backgroundColor: buttonColor),
                onPressed: () {
                  String newtext = "";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Year'),
                        content: TextField(
                          cursorColor: buttonColor,
                          autofocus: true,
                          onChanged: (text) {
                            newtext = text;
                          },
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                            child: const Text('Done'),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _addYear(newtext);
                              });
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            sizedBox10(),
            Text('Select Album', style: myTextStyle(whiteColor)),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: DropdownButton<String>(
                hint: const Text('Select Album'),
                // value: _selectedAlbum,
                items: _albums.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedAlbum = newValue!;
                  });
                  
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 90),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.album_outlined),
                label: const Text('Add Album'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    backgroundColor:buttonColor,
                    ),
                onPressed: () {
                  String newtext = "";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        
                        title: const Text('Add Album'),
                        content: TextField(
                          autofocus: true,
                          cursorColor: buttonColor,
                          onChanged: (text) {
                            newtext = text;
                            // _addAlbum(text);
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                            child: const Text('Done'),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _addAlbum(newtext);
                              });
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            sizedBox10(),
            Text('Select Genre', style: myTextStyle(whiteColor)),
            sizedBox10(),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: DropdownButton<String>(
                hint: const Text('Select Genre'),
                // value: _selectedGenre,
                items: _genres.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                     _selectedGenre = newValue!;
                  });
                },
              ),
            ),
            sizedBox10(),
            Text('Select Tempo', style: myTextStyle(whiteColor)),
            sizedBox10(),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 90),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.miscellaneous_services),
                onPressed: _selectAudioFile,
                label: const Text('Load Song'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    backgroundColor: buttonColor),
              ),
            ),
            sizedBox10(),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 90),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.library_music),
                onPressed: _addNewSong,
                label: const Text('Add Song'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    backgroundColor: buttonColor),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Back/Exit",
                style: myTextStyle(whiteColor),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
