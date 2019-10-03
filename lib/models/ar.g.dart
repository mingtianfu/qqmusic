// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ar _$ArFromJson(Map<String, dynamic> json) {
  return Ar()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..tns = json['tns'] as List
    ..alias = json['alias'] as List;
}

Map<String, dynamic> _$ArToJson(Ar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tns': instance.tns,
      'alias': instance.alias
    };
