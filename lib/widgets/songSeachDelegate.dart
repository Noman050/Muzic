// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../controllers/playerController.dart';
import '../screens/playerScreen.dart';

class SongSearchDelegate extends SearchDelegate<String> {
  final List<SongModel> data;

  SongSearchDelegate({required this.data});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: buttonColor,
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: buttonColor,
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  
  Widget buildResults(BuildContext context) {
    // Perform search and display results
    final List<SongModel> searchResults = data.where((song) => song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final song = searchResults[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            child:
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
              tileColor: bgColor,
              textColor: whiteColor,
              title: Text(song.displayNameWOExt),
              subtitle: Text(song.artist.toString()),
              onTap: () {
              final playerController = Get.find<PlayerController>();
                playerController.playSong(song.uri, index, data);
              
                // Open the player screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerScreen(data: data),
                  ),
                );
              },
            )
            
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display suggestions as the user types
    final List<SongModel> suggestions = data.where((song) => song.displayNameWOExt.toLowerCase().contains(query.toLowerCase())).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final song = suggestions[index];
          final songs=suggestions;
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: 
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
              tileColor: bgColor,
              textColor: whiteColor,
              title: Text(song.displayNameWOExt),
              subtitle: Text(song.artist.toString()),
              onTap: () {
              final playerController = Get.find<PlayerController>();
                playerController.playSong(song.uri, index, data);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerScreen(data: songs),
                  ),
                );
              },
            )
            
          );
        },
      ),
    );
  }
}