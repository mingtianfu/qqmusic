// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trackItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackItem _$TrackItemFromJson(Map<String, dynamic> json) {
  return TrackItem()
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..pst = json['pst'] as num
    ..t = json['t'] as num
    ..ar = (json['ar'] as List)
        ?.map((e) => e == null ? null : Ar.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..alia = json['alia'] as List
    ..pop = json['pop'] as num
    ..st = json['st'] as num
    ..rt = json['rt'] as String
    ..fee = json['fee'] as num
    ..v = json['v'] as num
    ..crbt = json['crbt'] as String
    ..cf = json['cf'] as String
    ..al = json['al'] == null
        ? null
        : Al.fromJson(json['al'] as Map<String, dynamic>)
    ..dt = json['dt'] as num
    ..h = json['h'] as Map<String, dynamic>
    ..m = json['m'] as Map<String, dynamic>
    ..l = json['l'] as Map<String, dynamic>
    ..a = json['a'] as String
    ..cd = json['cd'] as String
    ..no = json['no'] as num
    ..rtUrl = json['rtUrl'] as String
    ..ftype = json['ftype'] as num
    ..rtUrls = json['rtUrls'] as List
    ..djId = json['djId'] as num
    ..copyright = json['copyright'] as num
    ..s_id = json['s_id'] as num
    ..mark = json['mark'] as num
    ..rtype = json['rtype'] as num
    ..rurl = json['rurl'] as String
    ..mst = json['mst'] as num
    ..cp = json['cp'] as num
    ..mv = json['mv'] as num
    ..publishTime = json['publishTime'] as num;
}

Map<String, dynamic> _$TrackItemToJson(TrackItem instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'pst': instance.pst,
      't': instance.t,
      'ar': instance.ar,
      'alia': instance.alia,
      'pop': instance.pop,
      'st': instance.st,
      'rt': instance.rt,
      'fee': instance.fee,
      'v': instance.v,
      'crbt': instance.crbt,
      'cf': instance.cf,
      'al': instance.al,
      'dt': instance.dt,
      'h': instance.h,
      'm': instance.m,
      'l': instance.l,
      'a': instance.a,
      'cd': instance.cd,
      'no': instance.no,
      'rtUrl': instance.rtUrl,
      'ftype': instance.ftype,
      'rtUrls': instance.rtUrls,
      'djId': instance.djId,
      'copyright': instance.copyright,
      's_id': instance.s_id,
      'mark': instance.mark,
      'rtype': instance.rtype,
      'rurl': instance.rurl,
      'mst': instance.mst,
      'cp': instance.cp,
      'mv': instance.mv,
      'publishTime': instance.publishTime
    };
