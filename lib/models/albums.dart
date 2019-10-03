import 'package:json_annotation/json_annotation.dart';
import "albumItem.dart";
part 'albums.g.dart';

@JsonSerializable()
class Albums {
    Albums();

    num total;
    List<AlbumItem> albums;
    num code;
    
    factory Albums.fromJson(Map<String,dynamic> json) => _$AlbumsFromJson(json);
    Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}
