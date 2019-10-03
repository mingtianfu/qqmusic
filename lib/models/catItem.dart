import 'package:json_annotation/json_annotation.dart';

part 'catItem.g.dart';

@JsonSerializable()
class CatItem {
    CatItem();

    String name;
    num resourceCount;
    num imgId;
    String imgUrl;
    num type;
    num category;
    num resourceType;
    bool hot;
    bool activity;
    
    factory CatItem.fromJson(Map<String,dynamic> json) => _$CatItemFromJson(json);
    Map<String, dynamic> toJson() => _$CatItemToJson(this);
}
