import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
    Profile();

    String avatarImgIdStr;
    String backgroundImgIdStr;
    bool defaultAvatar;
    String avatarUrl;
    num vipType;
    num gender;
    num accountStatus;
    num avatarImgId;
    num birthday;
    String nickname;
    num city;
    num backgroundImgId;
    num userType;
    String detailDescription;
    bool followed;
    num userId;
    String description;
    Map<String,dynamic> experts;
    bool mutual;
    String remarkName;
    String expertTags;
    num authStatus;
    num province;
    num djStatus;
    String backgroundUrl;
    String signature;
    num authority;
    String avatarImgId_str;
    num followeds;
    num follows;
    num eventCount;
    num playlistCount;
    num playlistBeSubscribedCount;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
