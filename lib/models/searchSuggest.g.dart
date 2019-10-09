// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchSuggest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSuggest _$SearchSuggestFromJson(Map<String, dynamic> json) {
  return SearchSuggest()
    ..keyword = json['keyword'] as String
    ..type = json['type'] as num
    ..alg = json['alg'] as String
    ..lastKeyword = json['lastKeyword'] as String;
}

Map<String, dynamic> _$SearchSuggestToJson(SearchSuggest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'type': instance.type,
      'alg': instance.alg,
      'lastKeyword': instance.lastKeyword
    };
