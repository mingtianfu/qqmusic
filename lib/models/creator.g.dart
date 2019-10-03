// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator()
    ..defaultAvatar = json['defaultAvatar'] as bool
    ..province = json['province'] as num
    ..authStatus = json['authStatus'] as num
    ..followed = json['followed'] as bool
    ..avatarUrl = json['avatarUrl'] as String
    ..accountStatus = json['accountStatus'] as num
    ..gender = json['gender'] as num
    ..city = json['city'] as num
    ..birthday = json['birthday'] as num
    ..userId = json['userId'] as num
    ..userType = json['userType'] as num
    ..nickname = json['nickname'] as String
    ..signature = json['signature'] as String
    ..description = json['description'] as String
    ..detailDescription = json['detailDescription'] as String
    ..avatarImgId = json['avatarImgId'] as num
    ..backgroundImgId = json['backgroundImgId'] as num
    ..backgroundUrl = json['backgroundUrl'] as String
    ..authority = json['authority'] as num
    ..mutual = json['mutual'] as bool
    ..expertTags = json['expertTags'] as List
    ..experts = json['experts'] as Map<String, dynamic>
    ..djStatus = json['djStatus'] as num
    ..vipType = json['vipType'] as num
    ..remarkName = json['remarkName'] as String
    ..avatarImgIdStr = json['avatarImgIdStr'] as String
    ..backgroundImgIdStr = json['backgroundImgIdStr'] as String
    ..avatarImgId_str = json['avatarImgId_str'] as String;
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'defaultAvatar': instance.defaultAvatar,
      'province': instance.province,
      'authStatus': instance.authStatus,
      'followed': instance.followed,
      'avatarUrl': instance.avatarUrl,
      'accountStatus': instance.accountStatus,
      'gender': instance.gender,
      'city': instance.city,
      'birthday': instance.birthday,
      'userId': instance.userId,
      'userType': instance.userType,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'description': instance.description,
      'detailDescription': instance.detailDescription,
      'avatarImgId': instance.avatarImgId,
      'backgroundImgId': instance.backgroundImgId,
      'backgroundUrl': instance.backgroundUrl,
      'authority': instance.authority,
      'mutual': instance.mutual,
      'expertTags': instance.expertTags,
      'experts': instance.experts,
      'djStatus': instance.djStatus,
      'vipType': instance.vipType,
      'remarkName': instance.remarkName,
      'avatarImgIdStr': instance.avatarImgIdStr,
      'backgroundImgIdStr': instance.backgroundImgIdStr,
      'avatarImgId_str': instance.avatarImgId_str
    };
