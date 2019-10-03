import 'package:json_annotation/json_annotation.dart';
import "playlistdetailp.dart";
part 'playlistdetail.g.dart';

@JsonSerializable()
class Playlistdetail {
    Playlistdetail();

    num code;
    String relatedVideos;
    Playlistdetailp playlist;
    String urls;
    List privileges;
    
    factory Playlistdetail.fromJson(Map<String,dynamic> json) => _$PlaylistdetailFromJson(json);
    Map<String, dynamic> toJson() => _$PlaylistdetailToJson(this);
}
