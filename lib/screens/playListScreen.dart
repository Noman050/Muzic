// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/playerScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:music_app/consts/colors.dart';
import 'package:music_app/widgets/myDrawer.dart';

import '../controllers/playerController.dart';

class PlaylistScreen extends StatefulWidget {
  final List<SongModel> data;
  const PlaylistScreen({super.key, required this.data});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<PlaylistModel> playlists = [];


  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  void loadPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList('playlists') ?? [];

    setState(() {
      playlists = playlistNames
          .map((name) => PlaylistModel(name: name, songs: widget.data))
          .toList();
    });
  }

  void createNewPlaylist() async {
    TextEditingController playlistNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text("Create Playlist", style: TextStyle(color: whiteColor),),
          content: TextField(
            cursorColor: buttonColor,
            style: const TextStyle(color: whiteColor),
            controller: playlistNameController,
            decoration: const InputDecoration(hintText: "Enter Name", fillColor: whiteColor, hintStyle: TextStyle(color: whiteColor), icon: Icon(Icons.text_fields, color: buttonColor,),),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: buttonColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Create",style: TextStyle(color: buttonColor),),
              onPressed: () async {
                String playlistName = playlistNameController.text.trim();

                if (playlistName.isNotEmpty) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String> playlistNames =
                      prefs.getStringList('playlists') ?? [];

                  if (!playlistNames.contains(playlistName)) {
                    playlistNames.add(playlistName);
                    prefs.setStringList('playlists', playlistNames);

                    setState(() {
                      playlists.add(
                        PlaylistModel(name: playlistName, songs: widget.data),
                      );
                    });
                  }
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deletePlaylist(PlaylistModel playlist) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text("Delete Playlist", style: TextStyle(color: whiteColor),),
          content: Text(
            "Are you sure you want to delete the playlist '${playlist.name}'?", style: const TextStyle(color: whiteColor)
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel",  style: TextStyle(color: buttonColor )),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: buttonColor)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> playlistNames = prefs.getStringList('playlists') ?? [];
      playlistNames.remove(playlist.name);
      prefs.setStringList('playlists', playlistNames);

      setState(() {
        playlists.remove(playlist);
      });
    }
  }

  void navigateToPlaylistDetail(PlaylistModel playlist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistDetailScreen(playlist: playlist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: buttonColor),
        backgroundColor: bgColor,
        title: const Text('Playlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: createNewPlaylist,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: bgColor,
                title: Text(
                  playlist.name,
                  style: const TextStyle(color: whiteColor),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: redColor,
                  onPressed: () => deletePlaylist(playlist),
                ),
                onTap: () => navigateToPlaylistDetail(playlist),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlaylistModel {
  final String name;
  List<SongModel> songs;

  PlaylistModel({required this.name, required this.songs});
}

class PlaylistDetailScreen extends StatefulWidget {
  final PlaylistModel playlist;

  const PlaylistDetailScreen({Key? key, required this.playlist})
      : super(key: key);

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {

  // mrthod to remove fong from playlist
  void removeFromPlaylist(PlaylistModel playlist, SongModel song) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text("Remove Song", style: TextStyle(color: whiteColor)),
          content: const Text(
            "Do you want to remove this song from the playlist?", style: TextStyle(color: whiteColor)
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: buttonColor)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Remove", style: TextStyle(color: buttonColor)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      setState(() {
        playlist.songs.remove(song);
      });
    }
  }

  // method to add song from playlist

  void addToPlaylist(PlaylistModel playlist, SongModel song) {
    setState(() {
      playlist.songs.add(song);
    });
  }


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        actions:  [
          IconButton(onPressed: (){
            
          }, icon: const Icon(Icons.add)),
        ],
        iconTheme: const IconThemeData(color: buttonColor),
        backgroundColor: bgColor,
        title: Text(widget.playlist.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.playlist.songs.length,
          itemBuilder: (context, index) {
            final song = widget.playlist.songs[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                tileColor: bgColor,
                onTap: (){
                  controller.playSong(song.uri, index, widget.playlist.songs);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(data: widget.playlist.songs),
                      ),
                    );
                },
                title: Text(song.displayNameWOExt, style: const TextStyle(color: whiteColor, fontSize: 15),),
                leading: QueryArtworkWidget(id: song.id, type: ArtworkType.AUDIO, nullArtworkWidget: const Icon(Icons.music_note, color: whiteColor, size: 32,),),
                subtitle: Text(song.artist.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: redColor,),
                  color: redColor,
                  onPressed: () => {
                    setState((){
                     removeFromPlaylist(widget.playlist, song);
                    })
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}