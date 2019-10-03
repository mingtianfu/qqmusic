// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatItem _$CatItemFromJson(Map<String, dynamic> json) {
  return CatItem()
    ..name = json['name'] as String
    ..resourceCount = json['resourceCount'] as num
    ..imgId = json['imgId'] as num
    ..imgUrl = json['imgUrl'] as String
    ..type = json['type'] as num
    ..category = json['category'] as num
    ..resourceType = json['resourceType'] as num
    ..hot = json['hot'] as bool
    ..activity = json['activity'] as bool;
}

Map<String, dynamic> _$CatItemToJson(CatItem instance) => <String, dynamic>{
      'name': instance.name,
      'resourceCount': instance.resourceCount,
      'imgId': instance.imgId,
      'imgUrl': instance.imgUrl,
      'type': instance.type,
      'category': instance.category,
      'resourceType': instance.resourceType,
      'hot': instance.hot,
      'activity': instance.activity
    };
