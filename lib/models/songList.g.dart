// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongList _$SongListFromJson(Map<String, dynamic> json) {
  return SongList()
    ..tracks = (json['tracks'] as List)
        ?.map((e) =>
            e == null ? null : TrackItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SongListToJson(SongList instance) =>
    <String, dynamic>{'tracks': instance.tracks};
