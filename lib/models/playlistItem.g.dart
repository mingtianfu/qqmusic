// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) {
  return PlaylistItem()
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..trackNumberUpdateTime = json['trackNumberUpdateTime'] as num
    ..status = json['status'] as num
    ..userId = json['userId'] as num
    ..createTime = json['createTime'] as num
    ..updateTime = json['updateTime'] as num
    ..subscribedCount = json['subscribedCount'] as num
    ..trackCount = json['trackCount'] as num
    ..cloudTrackCount = json['cloudTrackCount'] as num
    ..coverImgUrl = json['coverImgUrl'] as String
    ..coverImgId = json['coverImgId'] as num
    ..description = json['description'] as String
    ..tags = json['tags'] as List
    ..playCount = json['playCount'] as num
    ..trackUpdateTime = json['trackUpdateTime'] as num
    ..specialType = json['specialType'] as num
    ..totalDuration = json['totalDuration'] as num
    ..creator = json['creator'] as Map<String, dynamic>
    ..tracks = json['tracks'] as String
    ..subscribers = json['subscribers'] as List
    ..subscribed = json['subscribed'] as String
    ..commentThreadId = json['commentThreadId'] as String
    ..newImported = json['newImported'] as bool
    ..adType = json['adType'] as num
    ..highQuality = json['highQuality'] as bool
    ..privacy = json['privacy'] as num
    ..ordered = json['ordered'] as bool
    ..anonimous = json['anonimous'] as bool
    ..coverStatus = json['coverStatus'] as num
    ..shareCount = json['shareCount'] as num
    ..coverImgId_str = json['coverImgId_str'] as String
    ..commentCount = json['commentCount'] as num
    ..alg = json['alg'] as String;
}

Map<String, dynamic> _$PlaylistItemToJson(PlaylistItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'status': instance.status,
      'userId': instance.userId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'subscribedCount': instance.subscribedCount,
      'trackCount': instance.trackCount,
      'cloudTrackCount': instance.cloudTrackCount,
      'coverImgUrl': instance.coverImgUrl,
      'coverImgId': instance.coverImgId,
      'description': instance.description,
      'tags': instance.tags,
      'playCount': instance.playCount,
      'trackUpdateTime': instance.trackUpdateTime,
      'specialType': instance.specialType,
      'totalDuration': instance.totalDuration,
      'creator': instance.creator,
      'tracks': instance.tracks,
      'subscribers': instance.subscribers,
      'subscribed': instance.subscribed,
      'commentThreadId': instance.commentThreadId,
      'newImported': instance.newImported,
      'adType': instance.adType,
      'highQuality': instance.highQuality,
      'privacy': instance.privacy,
      'ordered': instance.ordered,
      'anonimous': instance.anonimous,
      'coverStatus': instance.coverStatus,
      'shareCount': instance.shareCount,
      'coverImgId_str': instance.coverImgId_str,
      'commentCount': instance.commentCount,
      'alg': instance.alg
    };
