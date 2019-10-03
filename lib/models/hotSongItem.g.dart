// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotSongItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSongItem _$HotSongItemFromJson(Map<String, dynamic> json) {
  return HotSongItem()
    ..rtUrls = json['rtUrls'] as List
    ..ar = json['ar'] as List
    ..al = json['al'] == null
        ? null
        : Al.fromJson(json['al'] as Map<String, dynamic>)
    ..st = json['st'] as num
    ..no = json['no'] as num
    ..fee = json['fee'] as num
    ..v = json['v'] as num
    ..djId = json['djId'] as num
    ..cd = json['cd'] as String
    ..mv = json['mv'] as num
    ..a = json['a'] as String
    ..m = json['m'] as Map<String, dynamic>
    ..rtype = json['rtype'] as num
    ..rurl = json['rurl'] as String
    ..crbt = json['crbt'] as String
    ..rtUrl = json['rtUrl'] as String
    ..ftype = json['ftype'] as num
    ..pst = json['pst'] as num
    ..t = json['t'] as num
    ..alia = json['alia'] as List
    ..pop = json['pop'] as num
    ..rt = json['rt'] as String
    ..mst = json['mst'] as num
    ..cp = json['cp'] as num
    ..cf = json['cf'] as String
    ..dt = json['dt'] as num
    ..h = json['h'] as Map<String, dynamic>
    ..l = json['l'] as Map<String, dynamic>
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..privilege = json['privilege'] as Map<String, dynamic>;
}

Map<String, dynamic> _$HotSongItemToJson(HotSongItem instance) =>
    <String, dynamic>{
      'rtUrls': instance.rtUrls,
      'ar': instance.ar,
      'al': instance.al,
      'st': instance.st,
      'no': instance.no,
      'fee': instance.fee,
      'v': instance.v,
      'djId': instance.djId,
      'cd': instance.cd,
      'mv': instance.mv,
      'a': instance.a,
      'm': instance.m,
      'rtype': instance.rtype,
      'rurl': instance.rurl,
      'crbt': instance.crbt,
      'rtUrl': instance.rtUrl,
      'ftype': instance.ftype,
      'pst': instance.pst,
      't': instance.t,
      'alia': instance.alia,
      'pop': instance.pop,
      'rt': instance.rt,
      'mst': instance.mst,
      'cp': instance.cp,
      'cf': instance.cf,
      'dt': instance.dt,
      'h': instance.h,
      'l': instance.l,
      'name': instance.name,
      'id': instance.id,
      'privilege': instance.privilege
    };
