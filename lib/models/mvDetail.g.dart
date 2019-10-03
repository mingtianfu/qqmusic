// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mvDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MvDetail _$MvDetailFromJson(Map<String, dynamic> json) {
  return MvDetail()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..artistId = json['artistId'] as num
    ..artistName = json['artistName'] as String
    ..briefDesc = json['briefDesc'] as String
    ..desc = json['desc'] as String
    ..cover = json['cover'] as String
    ..coverId = json['coverId'] as num
    ..playCount = json['playCount'] as num
    ..subCount = json['subCount'] as num
    ..shareCount = json['shareCount'] as num
    ..likeCount = json['likeCount'] as num
    ..commentCount = json['commentCount'] as num
    ..duration = json['duration'] as num
    ..nType = json['nType'] as num
    ..publishTime = json['publishTime'] as String
    ..artists = json['artists'] as List
    ..isReward = json['isReward'] as bool
    ..commentThreadId = json['commentThreadId'] as String;
}

Map<String, dynamic> _$MvDetailToJson(MvDetail instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'briefDesc': instance.briefDesc,
      'desc': instance.desc,
      'cover': instance.cover,
      'coverId': instance.coverId,
      'playCount': instance.playCount,
      'subCount': instance.subCount,
      'shareCount': instance.shareCount,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'duration': instance.duration,
      'nType': instance.nType,
      'publishTime': instance.publishTime,
      'artists': instance.artists,
      'isReward': instance.isReward,
      'commentThreadId': instance.commentThreadId
    };
