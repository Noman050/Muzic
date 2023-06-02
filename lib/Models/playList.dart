// ignore_for_file: file_names

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistModel {
  final String name;
  List<SongModel> songs;

  PlaylistModel({required this.name, required this.songs});
}