// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'al.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Al _$AlFromJson(Map<String, dynamic> json) {
  return Al()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..picUrl = json['picUrl'] as String
    ..tns = json['tns'] as List
    ..pic_str = json['pic_str'] as String
    ..pic = json['pic'] as num;
}

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'tns': instance.tns,
      'pic_str': instance.pic_str,
      'pic': instance.pic
    };
