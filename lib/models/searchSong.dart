import 'package:json_annotation/json_annotation.dart';
import "artistItem.dart";
import "albumItem.dart";
part 'searchSong.g.dart';

@JsonSerializable()
class SearchSong {
    SearchSong();

    num id;
    String name;
    List<ArtistItem> artists;
    AlbumItem album;
    num duration;
    num copyrightId;
    num status;
    List alias;
    num rtype;
    num ftype;
    num mvid;
    num fee;
    String rUrl;
    num mark;
    
    factory SearchSong.fromJson(Map<String,dynamic> json) => _$SearchSongFromJson(json);
    Map<String, dynamic> toJson() => _$SearchSongToJson(this);
}
