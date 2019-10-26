// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..avatarImgIdStr = json['avatarImgIdStr'] as String
    ..backgroundImgIdStr = json['backgroundImgIdStr'] as String
    ..defaultAvatar = json['defaultAvatar'] as bool
    ..avatarUrl = json['avatarUrl'] as String
    ..vipType = json['vipType'] as num
    ..gender = json['gender'] as num
    ..accountStatus = json['accountStatus'] as num
    ..avatarImgId = json['avatarImgId'] as num
    ..birthday = json['birthday'] as num
    ..nickname = json['nickname'] as String
    ..city = json['city'] as num
    ..backgroundImgId = json['backgroundImgId'] as num
    ..userType = json['userType'] as num
    ..detailDescription = json['detailDescription'] as String
    ..followed = json['followed'] as bool
    ..userId = json['userId'] as num
    ..description = json['description'] as String
    ..experts = json['experts'] as Map<String, dynamic>
    ..mutual = json['mutual'] as bool
    ..remarkName = json['remarkName'] as String
    ..expertTags = json['expertTags'] as String
    ..authStatus = json['authStatus'] as num
    ..province = json['province'] as num
    ..djStatus = json['djStatus'] as num
    ..backgroundUrl = json['backgroundUrl'] as String
    ..signature = json['signature'] as String
    ..authority = json['authority'] as num
    ..avatarImgId_str = json['avatarImgId_str'] as String
    ..followeds = json['followeds'] as num
    ..follows = json['follows'] as num
    ..eventCount = json['eventCount'] as num
    ..playlistCount = json['playlistCount'] as num
    ..playlistBeSubscribedCount = json['playlistBeSubscribedCount'] as num;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'avatarImgIdStr': instance.avatarImgIdStr,
      'backgroundImgIdStr': instance.backgroundImgIdStr,
      'defaultAvatar': instance.defaultAvatar,
      'avatarUrl': instance.avatarUrl,
      'vipType': instance.vipType,
      'gender': instance.gender,
      'accountStatus': instance.accountStatus,
      'avatarImgId': instance.avatarImgId,
      'birthday': instance.birthday,
      'nickname': instance.nickname,
      'city': instance.city,
      'backgroundImgId': instance.backgroundImgId,
      'userType': instance.userType,
      'detailDescription': instance.detailDescription,
      'followed': instance.followed,
      'userId': instance.userId,
      'description': instance.description,
      'experts': instance.experts,
      'mutual': instance.mutual,
      'remarkName': instance.remarkName,
      'expertTags': instance.expertTags,
      'authStatus': instance.authStatus,
      'province': instance.province,
      'djStatus': instance.djStatus,
      'backgroundUrl': instance.backgroundUrl,
      'signature': instance.signature,
      'authority': instance.authority,
      'avatarImgId_str': instance.avatarImgId_str,
      'followeds': instance.followeds,
      'follows': instance.follows,
      'eventCount': instance.eventCount,
      'playlistCount': instance.playlistCount,
      'playlistBeSubscribedCount': instance.playlistBeSubscribedCount
    };
