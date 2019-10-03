import 'package:json_annotation/json_annotation.dart';

part 'creator.g.dart';

@JsonSerializable()
class Creator {
    Creator();

    bool defaultAvatar;
    num province;
    num authStatus;
    bool followed;
    String avatarUrl;
    num accountStatus;
    num gender;
    num city;
    num birthday;
    num userId;
    num userType;
    String nickname;
    String signature;
    String description;
    String detailDescription;
    num avatarImgId;
    num backgroundImgId;
    String backgroundUrl;
    num authority;
    bool mutual;
    List expertTags;
    Map<String,dynamic> experts;
    num djStatus;
    num vipType;
    String remarkName;
    String avatarImgIdStr;
    String backgroundImgIdStr;
    String avatarImgId_str;
    
    factory Creator.fromJson(Map<String,dynamic> json) => _$CreatorFromJson(json);
    Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
