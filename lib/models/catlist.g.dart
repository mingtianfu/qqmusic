// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catlist _$CatlistFromJson(Map<String, dynamic> json) {
  return Catlist()
    ..all = json['all'] == null
        ? null
        : CatItem.fromJson(json['all'] as Map<String, dynamic>)
    ..sub = (json['sub'] as List)
        ?.map((e) =>
            e == null ? null : CatItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..categories = json['categories'] as Map<String, dynamic>
    ..code = json['code'] as num;
}

Map<String, dynamic> _$CatlistToJson(Catlist instance) => <String, dynamic>{
      'all': instance.all,
      'sub': instance.sub,
      'categories': instance.categories,
      'code': instance.code
    };
