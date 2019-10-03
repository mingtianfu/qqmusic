// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerItem _$BannerItemFromJson(Map<String, dynamic> json) {
  return BannerItem()
    ..pic = json['pic'] as String
    ..targetId = json['targetId'] as num
    ..adid = json['adid'] as String
    ..targetType = json['targetType'] as num
    ..titleColor = json['titleColor'] as String
    ..typeTitle = json['typeTitle'] as String
    ..url = json['url'] as String
    ..adurlV2 = json['adurlV2'] as String
    ..exclusive = json['exclusive'] as bool
    ..monitorImpress = json['monitorImpress'] as String
    ..monitorClick = json['monitorClick'] as String
    ..monitorType = json['monitorType'] as String
    ..monitorImpressList = json['monitorImpressList'] as List
    ..monitorClickList = json['monitorClickList'] as List
    ..monitorBlackList = json['monitorBlackList'] as String
    ..extMonitor = json['extMonitor'] as String
    ..extMonitorInfo = json['extMonitorInfo'] as String
    ..adSource = json['adSource'] as String
    ..adLocation = json['adLocation'] as String
    ..encodeId = json['encodeId'] as String
    ..program = json['program'] as String
    ..event = json['event'] as String
    ..video = json['video'] as String
    ..song = json['song'] == null
        ? null
        : Song.fromJson(json['song'] as Map<String, dynamic>)
    ..bannerId = json['bannerId'] as String
    ..alg = json['alg'] as String
    ..scm = json['scm'] as String
    ..requestId = json['requestId'] as String
    ..showAdTag = json['showAdTag'] as bool
    ..pid = json['pid'] as String
    ..showContext = json['showContext'] as String
    ..adDispatchJson = json['adDispatchJson'] as String;
}

Map<String, dynamic> _$BannerItemToJson(BannerItem instance) =>
    <String, dynamic>{
      'pic': instance.pic,
      'targetId': instance.targetId,
      'adid': instance.adid,
      'targetType': instance.targetType,
      'titleColor': instance.titleColor,
      'typeTitle': instance.typeTitle,
      'url': instance.url,
      'adurlV2': instance.adurlV2,
      'exclusive': instance.exclusive,
      'monitorImpress': instance.monitorImpress,
      'monitorClick': instance.monitorClick,
      'monitorType': instance.monitorType,
      'monitorImpressList': instance.monitorImpressList,
      'monitorClickList': instance.monitorClickList,
      'monitorBlackList': instance.monitorBlackList,
      'extMonitor': instance.extMonitor,
      'extMonitorInfo': instance.extMonitorInfo,
      'adSource': instance.adSource,
      'adLocation': instance.adLocation,
      'encodeId': instance.encodeId,
      'program': instance.program,
      'event': instance.event,
      'video': instance.video,
      'song': instance.song,
      'bannerId': instance.bannerId,
      'alg': instance.alg,
      'scm': instance.scm,
      'requestId': instance.requestId,
      'showAdTag': instance.showAdTag,
      'pid': instance.pid,
      'showContext': instance.showContext,
      'adDispatchJson': instance.adDispatchJson
    };
