// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toplistdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Toplistdetail _$ToplistdetailFromJson(Map<String, dynamic> json) {
  return Toplistdetail()
    ..subscribers = json['subscribers'] as List
    ..subscribed = json['subscribed'] as String
    ..creator = json['creator'] as String
    ..artists = json['artists'] as String
    ..tracks = (json['tracks'] as List)
        ?.map((e) => e == null
            ? null
            : Toplistdetailtrack.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..updateFrequency = json['updateFrequency'] as String
    ..backgroundCoverId = json['backgroundCoverId'] as num
    ..backgroundCoverUrl = json['backgroundCoverUrl'] as String
    ..ordered = json['ordered'] as bool
    ..status = json['status'] as num
    ..tags = json['tags'] as List
    ..userId = json['userId'] as num
    ..updateTime = json['updateTime'] as num
    ..coverImgId = json['coverImgId'] as num
    ..newImported = json['newImported'] as bool
    ..anonimous = json['anonimous'] as bool
    ..specialType = json['specialType'] as num
    ..coverImgUrl = json['coverImgUrl'] as String
    ..commentThreadId = json['commentThreadId'] as String
    ..trackCount = json['trackCount'] as num
    ..privacy = json['privacy'] as num
    ..trackUpdateTime = json['trackUpdateTime'] as num
    ..totalDuration = json['totalDuration'] as num
    ..trackNumberUpdateTime = json['trackNumberUpdateTime'] as num
    ..playCount = json['playCount'] as num
    ..subscribedCount = json['subscribedCount'] as num
    ..cloudTrackCount = json['cloudTrackCount'] as num
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..description = json['description'] as String
    ..createTime = json['createTime'] as num
    ..highQuality = json['highQuality'] as bool
    ..adType = json['adType'] as num
    ..coverImgId_str = json['coverImgId_str'] as String
    ..ToplistType = json['ToplistType'] as String;
}

Map<String, dynamic> _$ToplistdetailToJson(Toplistdetail instance) =>
    <String, dynamic>{
      'subscribers': instance.subscribers,
      'subscribed': instance.subscribed,
      'creator': instance.creator,
      'artists': instance.artists,
      'tracks': instance.tracks,
      'updateFrequency': instance.updateFrequency,
      'backgroundCoverId': instance.backgroundCoverId,
      'backgroundCoverUrl': instance.backgroundCoverUrl,
      'ordered': instance.ordered,
      'status': instance.status,
      'tags': instance.tags,
      'userId': instance.userId,
      'updateTime': instance.updateTime,
      'coverImgId': instance.coverImgId,
      'newImported': instance.newImported,
      'anonimous': instance.anonimous,
      'specialType': instance.specialType,
      'coverImgUrl': instance.coverImgUrl,
      'commentThreadId': instance.commentThreadId,
      'trackCount': instance.trackCount,
      'privacy': instance.privacy,
      'trackUpdateTime': instance.trackUpdateTime,
      'totalDuration': instance.totalDuration,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'playCount': instance.playCount,
      'subscribedCount': instance.subscribedCount,
      'cloudTrackCount': instance.cloudTrackCount,
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'createTime': instance.createTime,
      'highQuality': instance.highQuality,
      'adType': instance.adType,
      'coverImgId_str': instance.coverImgId_str,
      'ToplistType': instance.ToplistType
    };
