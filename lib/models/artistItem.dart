import 'package:json_annotation/json_annotation.dart';

part 'artistItem.g.dart';

@JsonSerializable()
class ArtistItem {
    ArtistItem();

    num img1v1Id;
    num topicPerson;
    List alias;
    num picId;
    num albumSize;
    num musicSize;
    String briefDesc;
    bool followed;
    String img1v1Url;
    String trans;
    String picUrl;
    String name;
    num id;
    num accountId;
    String picId_str;
    String img1v1Id_str;
    
    factory ArtistItem.fromJson(Map<String,dynamic> json) => _$ArtistItemFromJson(json);
    Map<String, dynamic> toJson() => _$ArtistItemToJson(this);
}
