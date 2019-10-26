// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchSong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSong _$SearchSongFromJson(Map<String, dynamic> json) {
  return SearchSong()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : ArtistItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..album = json['album'] == null
        ? null
        : AlbumItem.fromJson(json['album'] as Map<String, dynamic>)
    ..duration = json['duration'] as num
    ..copyrightId = json['copyrightId'] as num
    ..status = json['status'] as num
    ..alias = json['alias'] as List
    ..rtype = json['rtype'] as num
    ..ftype = json['ftype'] as num
    ..mvid = json['mvid'] as num
    ..fee = json['fee'] as num
    ..rUrl = json['rUrl'] as String
    ..mark = json['mark'] as num;
}

Map<String, dynamic> _$SearchSongToJson(SearchSong instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artists': instance.artists,
      'album': instance.album,
      'duration': instance.duration,
      'copyrightId': instance.copyrightId,
      'status': instance.status,
      'alias': instance.alias,
      'rtype': instance.rtype,
      'ftype': instance.ftype,
      'mvid': instance.mvid,
      'fee': instance.fee,
      'rUrl': instance.rUrl,
      'mark': instance.mark
    };
