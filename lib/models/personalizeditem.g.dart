// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalizeditem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personalizeditem _$PersonalizeditemFromJson(Map<String, dynamic> json) {
  return Personalizeditem()
    ..id = json['id'] as num
    ..type = json['type'] as num
    ..name = json['name'] as String
    ..copywriter = json['copywriter'] as String
    ..picUrl = json['picUrl'] as String
    ..canDislike = json['canDislike'] as bool
    ..playCount = json['playCount'] as num
    ..trackCount = json['trackCount'] as num
    ..highQuality = json['highQuality'] as bool
    ..alg = json['alg'] as String;
}

Map<String, dynamic> _$PersonalizeditemToJson(Personalizeditem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'playCount': instance.playCount,
      'trackCount': instance.trackCount,
      'highQuality': instance.highQuality,
      'alg': instance.alg
    };
