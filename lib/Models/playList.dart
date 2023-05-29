// ignore_for_file: file_names


class Playlist {
  final String name;
  final List<MySongModel> songs;

  Playlist({required this.name, required this.songs});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    final List<dynamic> songData = json['songs'];
    final List<MySongModel> songs = songData.map((data) => MySongModel.fromJson(data)).toList();
    return Playlist(name: json['name'], songs: songs);
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> songJsonData = songs.map((song) => song.toJson()).toList();
    return {'name': name, 'songs': songJsonData};
  }
}

class MySongModel {
  final String displayNameWOExt;
  final String artist;
  final String uri;

  MySongModel({
    required this.displayNameWOExt,
    required this.artist,
    required this.uri,
  });

  factory MySongModel.fromJson(Map<String, dynamic> json) {
    return MySongModel(
      displayNameWOExt: json['displayNameWOExt'],
      artist: json['artist'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayNameWOExt': displayNameWOExt,
      'artist': artist,
      'uri': uri,
    };
  }
}

