// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Binding _$BindingFromJson(Map<String, dynamic> json) {
  return Binding()
    ..refreshTime = json['refreshTime'] as num
    ..tokenJsonStr = json['tokenJsonStr'] as String
    ..userId = json['userId'] as num
    ..url = json['url'] as String
    ..expired = json['expired'] as bool
    ..expiresIn = json['expiresIn'] as num
    ..bindingTime = json['bindingTime'] as num
    ..id = json['id'] as num
    ..type = json['type'] as num;
}

Map<String, dynamic> _$BindingToJson(Binding instance) => <String, dynamic>{
      'refreshTime': instance.refreshTime,
      'tokenJsonStr': instance.tokenJsonStr,
      'userId': instance.userId,
      'url': instance.url,
      'expired': instance.expired,
      'expiresIn': instance.expiresIn,
      'bindingTime': instance.bindingTime,
      'id': instance.id,
      'type': instance.type
    };
