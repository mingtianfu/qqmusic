// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumItem _$AlbumItemFromJson(Map<String, dynamic> json) {
  return AlbumItem()
    ..songs = json['songs'] as List
    ..paid = json['paid'] as bool
    ..onSale = json['onSale'] as bool
    ..mark = json['mark'] as num
    ..blurPicUrl = json['blurPicUrl'] as String
    ..companyId = json['companyId'] as num
    ..pic = json['pic'] as num
    ..alias = json['alias'] as List
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..copyrightId = json['copyrightId'] as num
    ..picId = json['picId'] as num
    ..artist = json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>)
    ..commentThreadId = json['commentThreadId'] as String
    ..briefDesc = json['briefDesc'] as String
    ..publishTime = json['publishTime'] as num
    ..picUrl = json['picUrl'] as String
    ..company = json['company'] as String
    ..tags = json['tags'] as String
    ..status = json['status'] as num
    ..subType = json['subType'] as String
    ..description = json['description'] as String
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..type = json['type'] as String
    ..size = json['size'] as num
    ..picId_str = json['picId_str'] as String
    ..transNames = json['transNames'] as List;
}

Map<String, dynamic> _$AlbumItemToJson(AlbumItem instance) => <String, dynamic>{
      'songs': instance.songs,
      'paid': instance.paid,
      'onSale': instance.onSale,
      'mark': instance.mark,
      'blurPicUrl': instance.blurPicUrl,
      'companyId': instance.companyId,
      'pic': instance.pic,
      'alias': instance.alias,
      'artists': instance.artists,
      'copyrightId': instance.copyrightId,
      'picId': instance.picId,
      'artist': instance.artist,
      'commentThreadId': instance.commentThreadId,
      'briefDesc': instance.briefDesc,
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'company': instance.company,
      'tags': instance.tags,
      'status': instance.status,
      'subType': instance.subType,
      'description': instance.description,
      'name': instance.name,
      'id': instance.id,
      'type': instance.type,
      'size': instance.size,
      'picId_str': instance.picId_str,
      'transNames': instance.transNames
    };
