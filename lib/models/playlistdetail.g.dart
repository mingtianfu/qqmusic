// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlistdetail _$PlaylistdetailFromJson(Map<String, dynamic> json) {
  return Playlistdetail()
    ..code = json['code'] as num
    ..relatedVideos = json['relatedVideos'] as String
    ..playlist = json['playlist'] == null
        ? null
        : Playlistdetailp.fromJson(json['playlist'] as Map<String, dynamic>)
    ..urls = json['urls'] as String
    ..privileges = json['privileges'] as List;
}

Map<String, dynamic> _$PlaylistdetailToJson(Playlistdetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'relatedVideos': instance.relatedVideos,
      'playlist': instance.playlist,
      'urls': instance.urls,
      'privileges': instance.privileges
    };
