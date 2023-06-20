// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/consts/sizedBox10.dart';
import 'package:music_app/screens/playerScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/colors.dart';
import '../controllers/playerController.dart';

class PlaylistModel {
  String name;
  List<SongModel> songs;

  PlaylistModel({required this.name, required this.songs});
}

class PlaylistScreen extends StatefulWidget {
  final List<SongModel> data;
  const PlaylistScreen({super.key, required this.data,});

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
          .map((name) => PlaylistModel(name: name, songs: []))
          .toList();
    });
  }

  void createNewPlaylist() async {
    TextEditingController playlistNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Create Playlist"),
          content: TextField(
            controller: playlistNameController,
            decoration: const InputDecoration(hintText: "Enter Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Create"),
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
                        PlaylistModel(name: playlistName, songs: []),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> playlistNames = prefs.getStringList('playlists') ?? [];

    playlistNames.remove(playlist.name);
    prefs.setStringList('playlists', playlistNames);

    setState(() {
      playlists.remove(playlist);
    });
  }

  void openPlaylistDetail(PlaylistModel playlist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistDetailScreen(playlist: playlist, data: widget.data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlists"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              createNewPlaylist();
            },
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                tileColor: bgColor,
                title: Text(playlist.name, style: const TextStyle(color: whiteColor),),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: redColor,),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){ 
                      return AlertDialog(
                      title: const Text("Do you want to delete this playlist?"),
                      content: const Text("Playlist with all data will be deleted."),
                      actions: [
                      TextButton(onPressed: (){
                        deletePlaylist(playlist);
                        Navigator.of(context).pop();
                      }, child: const Text("Ok")),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("Cancel")),
                      ],
                    );
                    },
                    );
                  },
                ),
                onTap: () {
                  openPlaylistDetail(playlist);
                },
              ),
            );
          },
        ),
      ),
    );
    
  }
}

class PlaylistDetailScreen extends StatefulWidget {
  final PlaylistModel playlist;
  final List<SongModel> data;

  const PlaylistDetailScreen({super.key, required this.playlist, required this.data});

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  // remove the selected song from the playlist
  void removeSongFromPlaylist(SongModel song) {
    setState(() {
      widget.playlist.songs.remove(song);
    });
  }
  // add the selected songs to the playlist
  void addSongToPlaylist() async {
    final List<SongModel> songs = widget.data;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)
          ),
          backgroundColor: bgColor,
          title: const Text("Select Songs", style: TextStyle(color: whiteColor),),
          icon: const Icon(Icons.list, color: buttonColor,),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 400,
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return ListTile(
                        title: Text(song.title.toString(), style: const TextStyle(color: whiteColor),),
                        trailing: IconButton(
                          icon: const Icon(Icons.add, color: buttonColor,),
                          onPressed: () {
                            setState(() {
                                if(!widget.playlist.songs.contains(song)){
                                widget.playlist.songs.add(song);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${song.title.toLowerCase()} Added To ${widget.playlist.name.toString()}"), duration: const Duration(seconds: 1)),
                                );
                                }
                                else{
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${song.title.toLowerCase()} is Already Exists in ${widget.playlist.name.toString()}"), duration: const Duration(seconds: 1)),
                                );
                                  });
                                  
                                }
                            });
                          },
                          
                        ),
                      );
                    },
                  ),
                ),
                sizedBox10(),
                sizedBox10(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  child: const Text("OK", style: TextStyle(color: blackColor),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.name),
        backgroundColor: bgColor,
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
                textColor: whiteColor,
                title: Text(song.title.toString()),
                leading: IconButton(
                      icon: const Icon(Icons.play_circle_filled, color: buttonColor,),
                      onPressed: () {
                        final playerController = Get.find<PlayerController>();
                       playerController.playSong(song.uri, index, widget.playlist.songs);
                        
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(data: widget.playlist.songs),
                      ),
                    );
                      },
                    ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: redColor,),
                  onPressed: () {
                     showDialog(context: context, builder: (BuildContext context){ 
                      return AlertDialog(
                      title: const Text("Do you want to delete this Music?"),
                      content: Text("This muzic will be deleted from ${widget.playlist.name}"),
                      actions: [
                      TextButton(onPressed: (){
                        removeSongFromPlaylist(song);
                        Navigator.of(context).pop();
                      }, child: const Text("Ok")),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("Cancel")),
                      ],
                    );
                    },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: const Icon(Icons.add, color: blackColor,),
        onPressed: () {
          addSongToPlaylist();
        },
      ),
    );
  }
}
