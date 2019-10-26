// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
    ..id = json['id'] as num
    ..userName = json['userName'] as String
    ..type = json['type'] as num
    ..status = json['status'] as num
    ..whitelistAuthority = json['whitelistAuthority'] as num
    ..createTime = json['createTime'] as num
    ..salt = json['salt'] as String
    ..tokenVersion = json['tokenVersion'] as num
    ..ban = json['ban'] as num
    ..baoyueVersion = json['baoyueVersion'] as num
    ..donateVersion = json['donateVersion'] as num
    ..vipType = json['vipType'] as num
    ..viptypeVersion = json['viptypeVersion'] as num
    ..anonimousUser = json['anonimousUser'] as bool;
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'type': instance.type,
      'status': instance.status,
      'whitelistAuthority': instance.whitelistAuthority,
      'createTime': instance.createTime,
      'salt': instance.salt,
      'tokenVersion': instance.tokenVersion,
      'ban': instance.ban,
      'baoyueVersion': instance.baoyueVersion,
      'donateVersion': instance.donateVersion,
      'vipType': instance.vipType,
      'viptypeVersion': instance.viptypeVersion,
      'anonimousUser': instance.anonimousUser
    };
