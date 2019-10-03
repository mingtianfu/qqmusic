import 'package:json_annotation/json_annotation.dart';
import "artist.dart";
part 'albumItem.g.dart';

@JsonSerializable()
class AlbumItem {
    AlbumItem();

    List songs;
    bool paid;
    bool onSale;
    num mark;
    String blurPicUrl;
    num companyId;
    num pic;
    List alias;
    List<Artist> artists;
    num copyrightId;
    num picId;
    Artist artist;
    String commentThreadId;
    String briefDesc;
    num publishTime;
    String picUrl;
    String company;
    String tags;
    num status;
    String subType;
    String description;
    String name;
    num id;
    String type;
    num size;
    String picId_str;
    List transNames;
    
    factory AlbumItem.fromJson(Map<String,dynamic> json) => _$AlbumItemFromJson(json);
    Map<String, dynamic> toJson() => _$AlbumItemToJson(this);
}
