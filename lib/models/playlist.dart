import 'package:json_annotation/json_annotation.dart';
import "playlistItem.dart";
part 'playlist.g.dart';

@JsonSerializable()
class Playlist {
    Playlist();

    List<PlaylistItem> playlists;
    num total;
    num code;
    bool more;
    String cat;
    
    factory Playlist.fromJson(Map<String,dynamic> json) => _$PlaylistFromJson(json);
    Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
