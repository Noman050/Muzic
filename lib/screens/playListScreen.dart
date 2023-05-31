// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/consts/colors.dart';
import 'package:music_app/widgets/myDrawer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playerController.dart';
import './playerScreen.dart';

class PlaylistScreen extends StatefulWidget {
  final List<SongModel> data;

  const PlaylistScreen({Key? key, required this.data}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<SongModel> playlist = [];

  @override
  void initState() {
    super.initState();
    playlist = List.from(widget.data);
  }

  void addToPlaylist(SongModel song) {
    setState(() {
      playlist.add(song);
    });
  }

  void removeFromPlaylist(SongModel song) {
    setState(() {
      playlist.remove(song);
    });
  }

  void createNewPlaylist() {
    // Implement functionality to create a new playlist
  }

  void deletePlaylist() {
    // Implement functionality to delete the playlist with warning message
  }

  void navigateToPlayerScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerScreen(data: playlist)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        title: const Text('Playlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deletePlaylist,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            final song = playlist[index];
            final songs = playlist;
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                tileColor: bgColor,
                title: Text(
                  song.displayNameWOExt,
                  style: const TextStyle(color: whiteColor),
                ),
                subtitle: Text(
                  song.artist.toString(),
                  style: const TextStyle(color: white54Color),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: redColor,
                  onPressed: () {
                    removeFromPlaylist(song);
                  },
                ),
                onTap: () {
                  final playerController = Get.find<PlayerController>();
                  playerController.playSong(song.uri, index, songs);
                  navigateToPlayerScreen();
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgDarkColor,
        unselectedItemColor: whiteColor,
        selectedItemColor: buttonColor,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            
          } else if (index == 2) {
            navigateToPlayerScreen();
            // Implement the functionality for the third bottom navigation bar item
          }
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: bgDarkColor,
            icon: Icon(Icons.playlist_play),
            label: 'Current PlayList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            label: 'Create Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
