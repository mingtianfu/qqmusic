import 'package:json_annotation/json_annotation.dart';
import "trackItem.dart";
part 'songList.g.dart';

@JsonSerializable()
class SongList {
    SongList();

    List<TrackItem> tracks;
    
    factory SongList.fromJson(Map<String,dynamic> json) => _$SongListFromJson(json);
    Map<String, dynamic> toJson() => _$SongListToJson(this);
}
