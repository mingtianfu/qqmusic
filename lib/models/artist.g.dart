// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist()
    ..img1v1Id = json['img1v1Id'] as num
    ..topicPerson = json['topicPerson'] as num
    ..alias = json['alias'] as List
    ..picId = json['picId'] as num
    ..albumSize = json['albumSize'] as num
    ..musicSize = json['musicSize'] as num
    ..briefDesc = json['briefDesc'] as String
    ..followed = json['followed'] as bool
    ..img1v1Url = json['img1v1Url'] as String
    ..trans = json['trans'] as String
    ..picUrl = json['picUrl'] as String
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..picId_str = json['picId_str'] as String
    ..transNames = json['transNames'] as List
    ..img1v1Id_str = json['img1v1Id_str'] as String;
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'img1v1Id': instance.img1v1Id,
      'topicPerson': instance.topicPerson,
      'alias': instance.alias,
      'picId': instance.picId,
      'albumSize': instance.albumSize,
      'musicSize': instance.musicSize,
      'briefDesc': instance.briefDesc,
      'followed': instance.followed,
      'img1v1Url': instance.img1v1Url,
      'trans': instance.trans,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'id': instance.id,
      'picId_str': instance.picId_str,
      'transNames': instance.transNames,
      'img1v1Id_str': instance.img1v1Id_str
    };
