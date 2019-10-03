// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mvItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MvItem _$MvItemFromJson(Map<String, dynamic> json) {
  return MvItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..status = json['status'] as num
    ..artist = json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>)
    ..artistName = json['artistName'] as String
    ..imgurl = json['imgurl'] as String
    ..imgurl16v9 = json['imgurl16v9'] as String
    ..duration = json['duration'] as num
    ..playCount = json['playCount'] as num
    ..publishTime = json['publishTime'] as String
    ..subed = json['subed'] as bool;
}

Map<String, dynamic> _$MvItemToJson(MvItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'artist': instance.artist,
      'artistName': instance.artistName,
      'imgurl': instance.imgurl,
      'imgurl16v9': instance.imgurl16v9,
      'duration': instance.duration,
      'playCount': instance.playCount,
      'publishTime': instance.publishTime,
      'subed': instance.subed
    };
