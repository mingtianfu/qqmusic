import 'package:json_annotation/json_annotation.dart';
import "artist.dart";
part 'mvItem.g.dart';

@JsonSerializable()
class MvItem {
    MvItem();

    num id;
    String name;
    num status;
    Artist artist;
    String artistName;
    String imgurl;
    String imgurl16v9;
    num duration;
    num playCount;
    String publishTime;
    bool subed;
    
    factory MvItem.fromJson(Map<String,dynamic> json) => _$MvItemFromJson(json);
    Map<String, dynamic> toJson() => _$MvItemToJson(this);
}
