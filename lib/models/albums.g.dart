// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) {
  return Albums()
    ..total = json['total'] as num
    ..albums = (json['albums'] as List)
        ?.map((e) =>
            e == null ? null : AlbumItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num;
}

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'total': instance.total,
      'albums': instance.albums,
      'code': instance.code
    };
