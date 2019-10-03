// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist()
    ..playlists = (json['playlists'] as List)
        ?.map((e) =>
            e == null ? null : PlaylistItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..total = json['total'] as num
    ..code = json['code'] as num
    ..more = json['more'] as bool
    ..cat = json['cat'] as String;
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'playlists': instance.playlists,
      'total': instance.total,
      'code': instance.code,
      'more': instance.more,
      'cat': instance.cat
    };
