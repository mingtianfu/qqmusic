// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyric _$LyricFromJson(Map<String, dynamic> json) {
  return Lyric()
    ..sgc = json['sgc'] as bool
    ..sfy = json['sfy'] as bool
    ..qfy = json['qfy'] as bool
    ..lrc = json['lrc'] as Map<String, dynamic>
    ..klyric = json['klyric'] as Map<String, dynamic>
    ..tlyric = json['tlyric'] as Map<String, dynamic>
    ..code = json['code'] as num;
}

Map<String, dynamic> _$LyricToJson(Lyric instance) => <String, dynamic>{
      'sgc': instance.sgc,
      'sfy': instance.sfy,
      'qfy': instance.qfy,
      'lrc': instance.lrc,
      'klyric': instance.klyric,
      'tlyric': instance.tlyric,
      'code': instance.code
    };
