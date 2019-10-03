// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistdetailp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlistdetailp _$PlaylistdetailpFromJson(Map<String, dynamic> json) {
  return Playlistdetailp()
    ..subscribers = json['subscribers'] as List
    ..subscribed = json['subscribed'] as bool
    ..creator = json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map<String, dynamic>)
    ..tracks = (json['tracks'] as List)
        ?.map((e) =>
            e == null ? null : TrackItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..trackIds = json['trackIds'] as List
    ..updateFrequency = json['updateFrequency'] as String
    ..backgroundCoverId = json['backgroundCoverId'] as num
    ..backgroundCoverUrl = json['backgroundCoverUrl'] as String
    ..subscribedCount = json['subscribedCount'] as num
    ..cloudTrackCount = json['cloudTrackCount'] as num
    ..createTime = json['createTime'] as num
    ..highQuality = json['highQuality'] as bool
    ..privacy = json['privacy'] as num
    ..trackUpdateTime = json['trackUpdateTime'] as num
    ..userId = json['userId'] as num
    ..updateTime = json['updateTime'] as num
    ..coverImgId = json['coverImgId'] as num
    ..newImported = json['newImported'] as bool
    ..specialType = json['specialType'] as num
    ..coverImgUrl = json['coverImgUrl'] as String
    ..trackCount = json['trackCount'] as num
    ..commentThreadId = json['commentThreadId'] as String
    ..playCount = json['playCount'] as num
    ..trackNumberUpdateTime = json['trackNumberUpdateTime'] as num
    ..adType = json['adType'] as num
    ..ordered = json['ordered'] as bool
    ..tags = json['tags'] as List
    ..description = json['description'] as String
    ..status = json['status'] as num
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..shareCount = json['shareCount'] as num
    ..coverImgId_str = json['coverImgId_str'] as String
    ..commentCount = json['commentCount'] as num;
}

Map<String, dynamic> _$PlaylistdetailpToJson(Playlistdetailp instance) =>
    <String, dynamic>{
      'subscribers': instance.subscribers,
      'subscribed': instance.subscribed,
      'creator': instance.creator,
      'tracks': instance.tracks,
      'trackIds': instance.trackIds,
      'updateFrequency': instance.updateFrequency,
      'backgroundCoverId': instance.backgroundCoverId,
      'backgroundCoverUrl': instance.backgroundCoverUrl,
      'subscribedCount': instance.subscribedCount,
      'cloudTrackCount': instance.cloudTrackCount,
      'createTime': instance.createTime,
      'highQuality': instance.highQuality,
      'privacy': instance.privacy,
      'trackUpdateTime': instance.trackUpdateTime,
      'userId': instance.userId,
      'updateTime': instance.updateTime,
      'coverImgId': instance.coverImgId,
      'newImported': instance.newImported,
      'specialType': instance.specialType,
      'coverImgUrl': instance.coverImgUrl,
      'trackCount': instance.trackCount,
      'commentThreadId': instance.commentThreadId,
      'playCount': instance.playCount,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'adType': instance.adType,
      'ordered': instance.ordered,
      'tags': instance.tags,
      'description': instance.description,
      'status': instance.status,
      'name': instance.name,
      'id': instance.id,
      'shareCount': instance.shareCount,
      'coverImgId_str': instance.coverImgId_str,
      'commentCount': instance.commentCount
    };
