import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
    Artist();

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
    String picId_str;
    List transNames;
    String img1v1Id_str;
    
    factory Artist.fromJson(Map<String,dynamic> json) => _$ArtistFromJson(json);
    Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
